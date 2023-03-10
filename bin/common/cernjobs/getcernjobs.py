#! /usr/bin/env python3

import json
import re

from datetime import datetime

import dateparser

from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

options = Options()
options.add_argument('--window-size=1920,1200')
options.add_argument('--headless')

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
driver.get('https://careers.cern/alljobs')

jobs = driver.find_elements(By.XPATH,      '/html/body/main/div[2]/div/div/div[2]/div/div[2]/div[*]')
job_links = driver.find_elements(By.XPATH, '/html/body/main/div[2]/div/div/div[2]/div/div[2]/div[*]/div/div[2]/div/div[4]/a')
job_list = []

def fix_date(date):
    date_sentence = date.text.split('no later than ')[1].split(' at')[0].split('(')[0].lower()

    for string_to_remove in ['gmt+1', 'midnight', 'th', 'cet']:
        date_sentence = date_sentence.replace(string_to_remove, '')

    return date_sentence.strip()

for (index, job) in enumerate(jobs):
    job_name = job.find_element(By.XPATH, './/div/div[1]/h4/a/div/h4').text
    try:
        job_link = job.find_element(By.XPATH, './/div/div[2]/div/div[4]/a').get_attribute('href')
    except NoSuchElementException:
        job_link = None
    parentheses = re.findall('\((.*?)\)', job_name)
    job_code = parentheses[-1] if len(parentheses) else ''
    job_code = 'NONE' if not '-' in job_code else '-'.join(job_code.split("-")[0:3])
    if "202" in job_code:
        job_code = job_code[:-5]

    job_list.append({
        "date": datetime.now().strftime('%Y-%m-%d'),
        "code": job_code,
        "name": job_name,
        "url": job_link,
    })

# dump fellowships and other stuff
def cool_job(job):
    uncool_jobs = ["internship", "associateship", "studentship", "post career", "shadowing", "research fellowship", "ukraine", "doctoral student", "administrative student"]

    return not any(uncool_job in job["name"].lower() for uncool_job in uncool_jobs)

job_list = [job for job in job_list if cool_job(job)]

# get final dates
for job in job_list:
    job_link = job['url']
    if job_link:
        driver.get(job_link)
        ps = driver.find_elements(By.XPATH, '//div[@itemprop="incentives"]/p')
        found = False

        for p in ps:
            # only thing we know is usually there...
            if 'no later than' in p.text:
                found = True
                date = fix_date(p)
                job["date"] = dateparser.parse(date, settings={'DATE_ORDER': 'DMY'}).strftime("%Y-%m-%d")
                break

# sort by date
job_list.sort(key=lambda j: j["date"], reverse=True)

with open('./cernjobs.json', 'w') as outfile:
    json.dump(job_list, outfile)

driver.quit()

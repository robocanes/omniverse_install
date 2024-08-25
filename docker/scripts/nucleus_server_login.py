import time

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Firefox()
driver.get('http://localhost:3080/connections')

time.sleep(2)

# <button class="sc-kpOJdX dAvFTR">Add</button>
add_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "sc-kpOJdX") and contains(@class, "dAvFTR")]'))
)
add_button.click()

server_input_field = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.CSS_SELECTOR, 'input[name="server"]'))
)

# Clear the input field and enter text
server_input_field.clear()  # Optional: Clear any existing text
server_input_field.send_keys('localhost')

# <button class="sc-gJWqzi sc-dTdPqK jhllc"> Next</button>
next_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "sc-gJWqzi") and contains(@class, "jhllc")]'))
)

next_button.click()

username_input_field = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.CSS_SELECTOR, 'input[name="username"]'))
)

# Clear the input field and enter text
username_input_field.clear()  # Optional: Clear any existing text
username_input_field.send_keys('admin')

password_input_field = WebDriverWait(driver, 10).until(
    EC.visibility_of_element_located((By.CSS_SELECTOR, 'input[name="password"]'))
)

password_input_field.clear()
password_input_field.send_keys('admin')

# <button class="sc-gJWqzi sc-dTdPqK jhllc"> Log in</button>
login_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "sc-dTdPqK") and contains(@class, "jhllc")]'))
)

login_button.click()

driver.quit()
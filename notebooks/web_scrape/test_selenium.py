from selenium import webdriver

# Set up the Chrome WebDriver
driver = webdriver.Chrome()

# Open the NomadList website
driver.get("https://nomadlist.com")

# Print the page title to verify the website loaded
print("Page Title:", driver.title)

# Close the browser
driver.quit()

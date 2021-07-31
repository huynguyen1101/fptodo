from Selenium2Library import Selenium2Library
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.remote.remote_connection import RemoteConnection
import datetime
import os
import threading
import json
from selenium.webdriver.chrome.options import Options
from selenium import webdriver

class ExtendedSeleniumLibrary(Selenium2Library):

    def __init__(self, *args, **kwargs):
        self.events_name = []
        self.browsers_number = []
        self.network_requests_logs = []
        self.max_browser_opened = 0
        Selenium2Library.__init__(self, *args, **kwargs)

    def stale_element_handler(self, kw, **kwargs):
        max_retry = 5
        iteration = 0

        if 'timeout' in kwargs.keys():
            timeout = robot.utils.timestr_to_secs(kwargs['timeout']) if kwargs['timeout'] is not None else self._timeout_in_secs
            maxtime = time.time() + timeout

        while True:
            try:
                if 'timeout' in kwargs.keys():
                    kwargs['timeout'] = maxtime - time.time()
                return kw(**kwargs)
            except StaleElementReferenceException:
                if iteration < max_retry:
                    print('Received StaleElementReferenceException. Retrying. Attempt #: %d' % (iteration + 1))
                    iteration += 1
                else:
                    print('Received StaleElementReferenceException %d times. Maximum retries was reached.' % iteration)
                    raise

    def wait_until_element_is_visible(self, locator, timeout=None, error=None):
        kwargs = {'locator':locator, 'timeout':timeout, 'error':error}
        return self.stale_element_handler(super(ExtendedSeleniumLibrary, self).wait_until_element_is_visible, **kwargs)

    def wait_until_element_is_not_visible(self, locator, timeout=None, error=None):
        kwargs = {'locator':locator, 'timeout':timeout, 'error':error}
        return self.stale_element_handler(super(ExtendedSeleniumLibrary, self).wait_until_element_is_not_visible, **kwargs)

    def mouse_out(self, locator):
        kwargs = {'locator':locator}
        return self.stale_element_handler(super(ExtendedSeleniumLibrary, self).mouse_out, **kwargs)

    def mouse_over(self, locator):
        kwargs = {'locator':locator}
        return self.stale_element_handler(super(ExtendedSeleniumLibrary, self).mouse_over, **kwargs)

    def click_element(self, locator):
        kwargs = {'locator':locator}
        return self.stale_element_handler(super(ExtendedSeleniumLibrary, self).click_element, **kwargs)

    def capture_page_screenshot(self, filename='selenium-screenshot'):
        try:
            # adding affix and suffix
            affix = get_robot_variable("SCREENSHOT_AFFIX")
            suffix = get_robot_variable("SCREENSHOT_SUFFIX")

            if affix is None and suffix is None:
                raise Exception("The affix and suffix are none")

            if affix == "" and suffix == "":
                raise Exception("The affix and suffix are empty strings")

            full_file_name = "{}-{}-{}-{index}-{}.png".format(str(affix), str(filename), str(suffix), datetime.datetime.now().strftime("%y%m%d%H%M%S"), index="{index}")
        except Exception as e:
            full_file_name = "{}-{index}-{}.png".format(filename, datetime.datetime.now().strftime("%y%m%d%H%M%S"), index="{index}")
            print("There are no environment variables defined for AFFIX and SUFFIX")
            print(e)
        finally:
            try:
                return super(ExtendedSeleniumLibrary, self).capture_page_screenshot(filename=full_file_name)
            except Exception as ex:
                print("Failed to save screenshot")
                print(ex)
                return ""

    def open_browser(self, url, browser='Chrome', alias=None, remote_url=False,
                     desired_capabilities=None, ff_profile_dir=None):
        
        super(ExtendedSeleniumLibrary, self).open_browser(url, browser, alias, remote_url, desired_capabilities, ff_profile_dir)

        self.browsers_number.append(len(self._cache.get_open_browsers()))
        self.events_name.append("Open Browser")

        if self.max_browser_opened < len(self._cache.get_open_browsers()):
            self.max_browser_opened = len(self._cache.get_open_browsers())

    def open_googlechrome(self, alias, remote_url):
        capabilities = {
            "browserName": "chrome",
            "chromeOptions": {
                "args": ["--start-maximized"],
            },
            "loggingPrefs": {
                "browser": "ALL",
                "performance": "ALL"
            },
            "perfLoggingPrefs": {
                "enableNetwork": True
            }
        }
        self.open_browser("about:blank", "googlechrome", alias, remote_url, capabilities)

    def open_chromium(self, alias, remote_url):
        capabilities = {
            "browserName": "chrome",
            "chromeOptions": {
                "args": ["--no-sandbox", "--start-maximized"],
                "binary": "usr/bin/chrome-linux/chrome"
            },
            "loggingPrefs": {
                "browser": "ALL",
                "performance": "ALL"
            },
            "perfLoggingPrefs": {
                "enableNetwork": True
            }
        }
        self.open_browser("about:blank", "googlechrome", alias, remote_url, capabilities)

    def close_browser(self):
        self.collect_network_requests_logs()
        super(ExtendedSeleniumLibrary, self).close_browser()
        self.browsers_number.append(len(self._cache.get_open_browsers()))
        self.events_name.append("Close Browser")

    def close_all_browsers(self):
        self.collect_network_requests_logs()
        super(ExtendedSeleniumLibrary, self).close_all_browsers()
        self.browsers_number.append(len(self._cache.get_open_browsers()))
        self.events_name.append("Close All Browsers")

    def collect_network_requests_logs(self):
         if os.environ.get("GENERATE_NETWORK_REQUESTS_DATA") == 'true':
            network_logs = get_type_logs_from_local_storage("NETWORK_REQUEST")
            if network_logs:
                self.network_requests_logs.extend(network_logs)

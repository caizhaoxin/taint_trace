import xml.dom.minidom as dom
import os


def get_app_package_name(package_name):
    xml_file = os.path.join('.', package_name, 'AndroidManifest.xml')
    root = dom.parse(xml_file)
    xml_root = root.documentElement
    package_name = xml_root.getAttribute('package')
    return package_name

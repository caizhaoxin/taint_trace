import xml.dom.minidom as dom
import os

xml_file = os.path.join('.', 'demo', 'AndroidManifest.xml')
root = dom.parse(xml_file)
print(root)
xml_root = root.documentElement
print(xml_root.nodeName)
print(xml_root.nodeValue)
print(xml_root.nodeType)
print(xml_root.ELEMENT_NODE)
package_name = xml_root.getAttribute('package')
print(package_name)

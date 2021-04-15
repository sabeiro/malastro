from setuptools import setup, find_packages

long_description = '''
most frequent returning patterns in shared mobility
'''

setup(
    name='scooter',
    version='0.0',
    author='Giovanni Marelli',
    author_email='marelli@inventati.org',
    description='patterns in shared mobility',
    long_description=long_description,
    license='Creative Commons Non-Commercial Share Alike 3.0',
    install_requires=['pandas','geopandas','numpy','scipy','descartes','folium','shapely'],
)

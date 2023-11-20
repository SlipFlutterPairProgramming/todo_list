from setuptools import setup
setup_requires = []
install_requires = [
    'fastApi>=0.104.1',
    'uvicorn>=0.20.0'
    ]

setup(
    name='slipp_todo_api',
    version='0.0.1',
    description='for 4th study',
    author='kingheadcat',
    install_requires=install_requires,
)

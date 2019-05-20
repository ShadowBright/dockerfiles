#!/bin/bash

# customise Jupyter setup with a few useful extensions
jupyter contrib nbextension install --user
jupyter nbextension enable toc2/main # table of contents
jupyter nbextension enable python-markdown/main # {{x}} in markdown cells gets rendered as the Python x variable
jupyter nbextension enable code_prettify/autopep8 # help with PEP8 compliance
jupyter nbextension enable execute_time/ExecuteTime # print execution time after each cell completes evaluation

# Add spark job progressbar integration for Jupyter notebook
# This does not work yet on Jupyter lab: https://github.com/mozilla/jupyter-spark/pull/41
jupyter serverextension enable --py jupyter_spark
jupyter nbextension install --py jupyter_spark
jupyter nbextension enable --py jupyter_spark
jupyter nbextension enable --py widgetsnbextension

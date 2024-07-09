#!/usr/bin/env python
# coding: utf-8

import os
env = os.getenv('APPDATA')
if env is None:
    os.environ["APPDATA"] = "."
import pandas as pd
# from pandasgui import show


# from pandasgui.datasets import titanic
df = pd.read_csv("~/Public/dataset/data_allégé.csv")

import tabloo

tabloo.show(titanic)

print("OK")

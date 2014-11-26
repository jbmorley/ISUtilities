#!/bin/bash

appledoc \
    --project-company "InSeven Limited" \
    --company-id "uk.co.inseven" \
    --project-name ISUtilities \
    --project-version "1.1.0" \
    --output Documentation \
    --create-docset \
    --index-desc README.md \
    --keep-undocumented-objects \
    --keep-undocumented-members \
    ISUtilities/*.h \
    UIKit+ISUtilities/*.h

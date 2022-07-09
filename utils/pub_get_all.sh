#!/bin/sh

echo "storage_view"
cd packages/storage_view
flutter pub get

echo "shared_preferences_storage_view_driver"
cd ../shared_preferences_storage_view_driver
flutter pub get

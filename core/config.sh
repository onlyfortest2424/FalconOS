#!/usr/bin/env bash

#########################################
# FalconOS Configuration v1.0
#########################################

#=====================================================
# Project Information
#=====================================================

FALCON_NAME="FalconOS"
FALCON_VERSION="1.0.0"
FALCON_EDITION="Community"

#=====================================================
# Base Paths
#=====================================================

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CORE_DIR="$BASE_DIR/core"
ASSETS_DIR="$BASE_DIR/assets"
DOCS_DIR="$BASE_DIR/docs"

PANEL_DIR="$BASE_DIR/panel"
TUNNEL_DIR="$BASE_DIR/tunnel"
TOOLS_DIR="$BASE_DIR/tools"
SECURITY_DIR="$BASE_DIR/security"
SYSTEM_DIR="$BASE_DIR/system"

#=====================================================
# Data Directories
#=====================================================

DATA_DIR="$BASE_DIR/data"
BACKUP_DIR="$DATA_DIR/backups"
LOG_DIR="$DATA_DIR/logs"
TMP_DIR="$DATA_DIR/tmp"

#=====================================================
# UI Settings
#=====================================================

LANGUAGE="en"
THEME="default"
SHOW_ICONS=true
SHOW_COLORS=true

#=====================================================
# Create Required Directories
#=====================================================

mkdir -p "$DATA_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$TMP_DIR"
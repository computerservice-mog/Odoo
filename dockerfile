# Use an official Python image as the base
FROM python:3.10-slim
 
# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    libjpeg-dev \
    libblas-dev \
    libatlas-base-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libffi-dev \
    libkrb5-dev \
    libyaml-dev \
    wget \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
 
# Set the working directory
WORKDIR /odoo
 
# Copy the source code into the container
COPY . /odoo
 
# Install Python dependencies (if any)
COPY requirements.txt /odoo/
RUN pip install -r /odoo/requirements.txt || true
 
# Expose Odoo port
EXPOSE 8069
 
# Start Odoo
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
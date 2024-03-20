FROM python:3.8-slim AS build

WORKDIR /app/backend

# Required for pipenv to build properly
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install OS dependencies
RUN apt-get update && \
    apt-get --yes --force-yes install postgresql-client openssh-server \
    && pip install --no-cache-dir --upgrade pipenv \
    && echo "root:Docker!" | chpasswd \
    && apt-get purge --auto-remove -yqq \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

# Set env
COPY ./backend/.env.prd .env

# Install application dependencies
COPY ./backend/Pipfile ./
RUN pipenv install

# Copy application
COPY . ./

# Open port 2222 for SSH access
EXPOSE 8000

# Run app
CMD ["pipenv", "run", "python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
FROM python:3.6

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -r requirements.txt --upgrade

COPY app app/

RUN python app/app.py

EXPOSE 5042

CMD ["gunicorn", "-b", "0.0.0.0:5042", "app:app"]

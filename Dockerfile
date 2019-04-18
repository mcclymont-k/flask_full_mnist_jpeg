FROM python:3.6

FROM ubuntu
RUN apt update && apt install -y python3

RUN apt-get update && apt-get install -y git python3-dev gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -r requirements.txt --upgrade

COPY app app/

RUN python app/app.py

EXPOSE 5044

CMD ["python", "app/app.py", "serve"]

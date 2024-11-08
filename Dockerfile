FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-rus libglib2.0-0 libsm6 libxext6 libxrender-dev && \
    apt-get clean

ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/5/tessdata/

RUN apt-get update && apt-get install -y git cmake g++
RUN git clone https://github.com/ggerganov/llama.cpp
WORKDIR llama.cpp
RUN cmake -B build
RUN cmake --build build --config Release

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

## Стек технологий и используемые инструменты

1. **Django**: Основной веб-фреймворк для обработки запросов, загрузки файлов и взаимодействия с фронтендом.
2. **Tesseract OCR**: Библиотека для извлечения текста из изображений. Используется для обработки изображений с текстом, загруженных пользователями.
3. **Vikhr-Llama-3.2-1B-F16.gguf**: LLM модель для суммаризации текста, выбранная за свою точность в обработке большого объема текстовой информации. 
4. **Docker и Docker Compose**: Используются для контейнеризации и управления сервисами, что облегчает развертывание и настройку приложения.
5. **Python и зависимости**: Пакеты, указанные в `requirements.txt`, обеспечивают поддержку для OCR, взаимодействие с LLM, обработку изображений и работу Django.

## Установка

### Шаг 1

```bash
git clone https://github.com/ramilevna/tender_analysis
cd tender_analysis
```
Download model (linux and mac):

wget https://huggingface.co/Vikhrmodels/Vikhr-Llama-3.2-1B-instruct-GGUF/resolve/main/Vikhr-Llama-3.2-1B-Q8_0.gguf

If you do not have wget:
1) for linux: sudo apt-get install wget
2) for mac: brew install wget
For windows:
Invoke-WebRequest -Uri "https://huggingface.co/Vikhrmodels/Vikhr-Llama-3.2-1B-instruct-GGUF/resolve/main/Vikhr-Llama-3.2-1B-Q8_0.gguf" -OutFile "Vikhr-Llama-3.2-1B-Q8_0.gguf"
### Шаг 2:

Запустите контейнеры и сервис:

```bash
docker-compose up --build
```

Django-сервер будет доступен по адресу [http://127.0.0.1:8000](http://127.0.0.1:8000).

## Использование сервиса

1. Перейдите на [http://127.0.0.1:8000/upload](http://127.0.0.1:8000/upload).
2. Загрузите изображение или текстовый документ для анализа.
3. Система использует Tesseract OCR для извлечения текста, затем передает текст в модель Vikhr-Llama для создания суммарного описания.
4. Результат буде суммаризации будет отображен в файлее

## Vikhr-Llama-3.2-1B-Q8_0.gguf: Модель для суммаризации текста

Было решено использовать данную модель для суммаризации текста ввиду того, что данная модель дообучена на русском датасете, соответсвенно она лучше понимает контекст, нежели оригинальная Llama 3.2. Более того, модель хорошо подходит для работы с ограниченными ресурсами (сама по себе весит чуть больше 2гб). Сама модель использовалась совместно с llama.cpp. Это фреймворк, который позволяет эффективно запускать большие языковые модели на CPU. Однако, ввиду ограниченных ресурсов, данная модель не будет работать на больших данных. Максимальное количество токенов в модели 4096, и с большими документами будет возникать ошибка, так как модель не способна обработать длинный контекст. Однако, при использовании большего количества ресурсов и выборе модели с большим контекстом (см. Mistral-Nemo (128k токенов, ~25гб)), мой сервис отлично бы справился с гораздо большим количеством документов.
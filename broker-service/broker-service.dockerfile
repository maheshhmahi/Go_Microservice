#base go image
FROM golang:1.23-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

# -o brokerApp - you are giving the name as brokerApp
RUN CGO_ENAGBLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

#build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD [ "/app/brokerApp" ]
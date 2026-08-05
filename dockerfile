FROM nginx:alpine as build
WORKDIR /usr/share/nginx/html
COPY . .
RUN pip install -r requirements.txt && \
    npm install && \
    npm run build

FROM distroless/nodejs:18
WORKDIR /app
COPY --from=build /usr/share/nginx/html .
CMD ["index.js"]
ENTRYPOINT ["node", "index.js"]


use axum::{
    http::{HeaderMap, HeaderValue, Method, StatusCode},
    routing::post,
    Json, Router,
};

use reqwest::header;
use serde::Deserialize;
use tower_http::cors::{Any, CorsLayer};
use tracing::info;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let cors = CorsLayer::new()
        .allow_methods(vec![Method::GET, Method::POST])
        .allow_origin(Any);
    let app = Router::new().route("/img", post(image)).layer(cors);

    let addr = "0.0.0.0:9527".parse().unwrap();

    info!("listening on {}", addr);

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

#[derive(Deserialize, Debug)]
struct SubUrl {
    url: String,
    page: String,
}

async fn image(Json(req): Json<SubUrl>) -> Result<(HeaderMap, Vec<u8>), StatusCode> {
    info!("{:#?}", req);
    let mut headers = header::HeaderMap::new();
    // 为我们的 HTTP 客户端添加一些缺省的 HTTP 头
    headers.insert("X-POWERED-BY", "Rust".parse().unwrap());
    headers.insert(header::USER_AGENT, "Rust Httpie".parse().unwrap());
    // 生成一个 HTTP 客户端
    let client = reqwest::Client::builder()
        .default_headers(headers)
        .build()
        .unwrap();
    let url = format!("{}/{}", req.url, req.page);
    let resp = client.get(url).send().await.unwrap().bytes().await.unwrap();

    let mut headers = HeaderMap::new();
    headers.insert("content-type", HeaderValue::from_static("image/jpeg"));

    Ok((headers, resp.to_vec()))
}

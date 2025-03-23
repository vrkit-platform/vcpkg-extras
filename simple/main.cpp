#include <IRacingSDK/LiveClient.h>
#include <fmt/format.h>
#include <iostream>

int main() {
  using namespace IRacingSDK;

  fmt::println("LiveClient isAvailable={}", LiveClient::Get().isAvailable());

  return 0;
}
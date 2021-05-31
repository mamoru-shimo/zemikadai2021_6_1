data {
  int N;                  // サンプルサイズ
  vector[N] sales;        // 売り上げ�?ータ
  vector[N] temperature;  // 気温�?ータ
  
  int N_pred;                        // 予測対象�?ータの大きさ
  vector[N_pred] temperature_pred;   // 予測対象となる気温
}

parameters {
  real Intercept;         // �?�?
  real beta;              // 係数
  real<lower=0> sigma;    // 標準偏差
}

model {
  // 平均Intercept + beta*temperature
  // 標準偏差sigmaの正規�??�?に従って�?ータが得られたと仮�?
  for (i in 1:N) {
    sales[i] ~ normal(Intercept + beta*temperature[i], sigma);
  }
}

generated quantities {
  vector[N_pred] mu_pred;           // ビ�?�ルの売り上げの期�?値
  vector[N_pred] sales_pred;        // ビ�?�ルの売り上げの予測値

  for (i in 1:N_pred) {
    mu_pred[i] = Intercept + beta*temperature_pred[i];
    sales_pred[i] = normal_rng(mu_pred[i], sigma);
  }
}

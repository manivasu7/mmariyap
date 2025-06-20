function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    baseUrl: 'http://bp-se-test-cabcd9b246a5.herokuapp.com',
    username: 'mmariyap'
  };
  
  if (env == 'dev') {
    // configuración específica para ambiente de desarrollo
  } else if (env == 'qa') {
    // configuración específica para ambiente de QA
  }
  
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  
  return config;
}

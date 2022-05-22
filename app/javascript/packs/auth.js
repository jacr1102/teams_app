const ENDPOINT_PATH = "http://localhost";

export default {
  headers: { headers: { 'Authorization' : '000' } },
  login(data) {
    const user = { user: data };
    return axios.post(ENDPOINT_PATH + "/login", user);
  },
  get(path) {
    return axios.get(ENDPOINT_PATH + path, this.headers );
  },
  post(path,data) {
    return axios.post(ENDPOINT_PATH + path, data, this.headers);
  },
  put(path,data) {
    return axios.put(ENDPOINT_PATH + path, data, this.headers);
  },
  delete(path) {
    return axios.delete(ENDPOINT_PATH + path, this.headers);
  },
  setHeaders(token){
    this.headers = { headers: { 'Authorization' : token } }
  }
};
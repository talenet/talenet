<template>
  <div class="catcodes">
    <h1>HTTP Status Cats API</h1>
    <small>from <a href="https://http.cat/">http.cat</a></small>


<ul>
  <li v-for="item in items" :key="item.code">
    <img :src="getImg(item)">
    <!-- <h4>{{item.message}}</h4> -->
  </li>
</ul>


  </div>
</template>

<script>
export default {
  name: 'catcodes',
  data () {
    return {
      items: [
        { code: 100, message: 'Continue' },
        { code: 101, message: 'Switching Protocols' },
        // { code: 102, message: 'Processing' },
        { code: 200, message: 'OK' },
        { code: 201, message: 'Created' },
        { code: 202, message: 'Accepted' },
        // { code: 203, message: 'Non-Authoritative Information' },
        { code: 204, message: 'No Content' },
        // { code: 205, message: 'Reset Content' },
        { code: 206, message: 'Partial Content' },
        { code: 300, message: 'Multiple Choices' },
        { code: 301, message: 'Moved Permanently' },
        { code: 302, message: 'Found' },
        { code: 303, message: 'See Other' },
        { code: 304, message: 'Not Modified' },
        { code: 305, message: 'Use Proxy' },
        // { code: 306, message: 'Unused' },
        { code: 307, message: 'Temporary Redirect' },
        // { code: 308, message: 'Permanent Redirect' },
        { code: 400, message: 'Bad Request' },
        { code: 401, message: 'Unauthorized' },
        { code: 402, message: 'Payment Required' },
        { code: 403, message: 'Forbidden' },
        { code: 404, message: 'Not Found' },
        { code: 405, message: 'Method Not Allowed' },
        { code: 406, message: 'Not Acceptable' },
        // { code: 407, message: 'Proxy Authentication Required' },
        { code: 408, message: 'Request Timeout' },
        { code: 409, message: 'Conflict' },
        { code: 410, message: 'Gone' },
        { code: 411, message: 'Length Required' },
        { code: 412, message: 'Precondition Failed' },
        { code: 413, message: 'Request Entry Too Large' },
        { code: 414, message: 'Request-URI Too Long' },
        { code: 415, message: 'Unsupported Media Type' },
        { code: 416, message: 'Requested Range Not Satisfiable' },
        { code: 417, message: 'Expectation Failed' },
        { code: 418, message: 'Im a teapot' },
        { code: 422, message: 'Unprocessable Entity' },
        // { code: 428, message: 'Precondition Required' },
        { code: 429, message: 'Too Many Requests' },
        { code: 431, message: 'Request Header Fields Too Large' },
        { code: 451, message: 'Unavailable For Legal Reasons' },
        { code: 500, message: 'Internal Server Error' },
        // { code: 501, message: 'Not Implemented' },
        { code: 502, message: 'Bad Gateway' },
        { code: 503, message: 'Service Unavailable' },
        { code: 504, message: 'Gateway Timeout' },
        // { code: 505, message: 'HTTP Version Not Supported' },
        { code: 511, message: 'Network Authentication Required' }
        // { code: 520, message: 'Web server is returning an unknown error' },
        // { code: 522, message: 'Connection timed out' },
        // {code: 524, message: 'A timeout occurre '}
      ]
    }
  },
  methods: {
    getImg: function (item) {
      return 'https://http.cat/' + item.code
    }
  }
}
</script>

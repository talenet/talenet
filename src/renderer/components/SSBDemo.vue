<template>
  <div class="ssbdemo">
    <h1>{{ $t('ssb.demo') }}</h1>

    <div v-if="!connected">
     <strong>whoops!</strong>
     <p>ssb not connected</p>
    </div>

    <div v-if="connected">
      <h2>Your ID</h2>
      <pre>{{ whoami }}</pre>
    </div>
    <hr>
    <h2>Post</h2>
    <div v-if="connected">
    <div v-html="preview"></div>
    <textarea v-model="message"></textarea>
    <button v-on:click="renderPrev">Preview Message</button>
    </div>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'

  export default {
    name: 'SSBDemo',
    data: () => {
      return {
        message: `write something...

* and
* try
* some

# markdown!`
      }
    },

    computed: {
      ...mapGetters({
        connected: 'ssb/connected',
        whoami: 'ssb/whoami'
      }),
      preview () {
        return this.$store.state.ssb.msgPreview
      }
    },

    methods: {
      renderPrev () {
        this.$store.commit('ssb/renderPreview', this.message)
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
  .ssbdemo {
    strong {
      color: red;
    }
    textarea {
      width: 100%;
      height: 25em;
    }
  }
</style>

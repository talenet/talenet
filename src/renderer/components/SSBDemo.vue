<template>
  <div class="ssbdemo">
    <h1>{{ $t('ssb.demo') }}</h1>

    <div v-if="!ssbConnected">
     <strong>whoops!</strong>
     <p>ssb not connected</p>
    </div>

    <div v-if="ssbConnected">
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
        ssbConnected: 'ssb/connected'
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

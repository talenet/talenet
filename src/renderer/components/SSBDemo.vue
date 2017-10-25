<template>
  <div class="ssbdemo">
    <h1>{{ $t('ssb.demo') }}</h1>

    <div v-if="!connected">
     <strong class="warning">whoops!</strong>
     <p>ssb not connected</p>
    </div>

    <div v-if="connected">
      <h2>Your ID</h2>
      <pre>{{ whoami }}</pre>
      <hr>
      <h2>Post</h2>
      <template v-if="publishedKey != ''">
        <strong class="warning">Just published:</strong>
        <pre>{{publishedKey}}</pre>
      </template>
      <div v-html="preview"></div>
      <textarea v-model="message"></textarea>
      <button v-on:click="renderPrev">Preview</button>
      <br>
      <button v-if="preview != ''" v-on:click="publishMsg">Publish Post</button>
      <hr>
      <h2>Latest Spam</h2>
      <ul>
        <li v-for="post in latest" :key="post.key">
          <!-- TODO: make these vue components -->
          <template v-if="post.value.content.type == 'post'">
            <small>From: {{post.value.author.slice(0,10)}}...</small>
            <small>on {{post.value.timestamp}}</small>
            <p>{{post.value.content.text}}</p>
          </template>
          <template v-else-if="post.value.content.type == 'contact'">
            <small>{{post.value.author.slice(0,10)}}...</small>
            <strong v-if="post.value.content.following">follows</strong>
            <strong v-else>unfollows</strong>
            <small>{{post.value.content.contact.slice(0,10)}}...</small>
          </template>
          <pre v-else>{{post}}</pre>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'

  export default {
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
      },
      latest () {
        return this.$store.state.ssb.latest
      },
      publishedKey () {
        return this.$store.state.ssb.publishedKey
      }
    },

    methods: {
      renderPrev () {
        this.$store.commit('ssb/renderPreview', this.message)
      },

      publishMsg () {
        this.$store.dispatch('ssb/publishPost')
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
  .ssbdemo {
    .warning {
      color: red;
    }
    textarea {
      width: 100%;
      height: 25em;
    }
  }
</style>

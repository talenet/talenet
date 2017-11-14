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
      <h4>Some stuff about you</h4>
      <ul>
        <li v-for="(abs, prop) in abouts(whoami)" :key="abs.key">
          <h5>{{prop}}</h5>
          <ul>
            <li v-for="(value, author) in abs" :key="value.id">
              <h6>{{author}}</h6>
              <pre>{{value.value}}</pre>
            </li>
          </ul>
        </li>
      </ul>

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
          <template v-else-if="post.value.content.type == 'vote'">
            <small>{{post.value.author.slice(0,10)}}...</small>
            <strong>voted {{post.value.content.vote.value}}</strong>
            <p>{{post.value.content.vote.link}}</p>
          </template>
          <template v-else-if="post.value.content.type == 'git-update'">
            <small>{{post.value.author.slice(0,10)}}...</small>
            <strong>pushed git changes to</strong>
            <small>{{post.value.content.repo}}</small>
          </template>
          <template v-else-if="post.value.content.type == 'channel'">
            <small>{{post.value.author.slice(0,10)}}...</small>
            <strong v-if="post.value.content.subscribed">subscribed</strong>
            <strong v-else>unsubscribed</strong>
            <small>channel {{post.value.content.channel}}</small>
          </template>
          <template v-else-if="typeof post.value.content === 'string'">
            <small>{{post.value.author.slice(0,10)}}...</small>
            <small>posted an encrypted message.</small>
          </template>
          <template v-else>
            <strong>unhandled type:</strong><small>{{post.value.content.type}}</small>
            <pre>{{post}}</pre>
          </template>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

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
        whoami: 'ssb/whoami',
        abouts: 'ssb/abouts'
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

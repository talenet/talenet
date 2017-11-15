<template>
  <div>
    <div v-if="loading">
      <t-loading-animation></t-loading-animation>
    </div>

    <div v-if="!loading && !exists">
      <h1>{{$t('idea.error.notFound')}}</h1>
    </div>

    <div v-if="!loading && exists">
      <h1>{{idea.title()}}</h1>

      <t-markdown-text :text="idea.description()"></t-markdown-text>
    </div>
  </div>
</template>

<script>
  export default {
    props: [
      'ideaKey'
    ],

    data () {
      return {
        loading: true,
        exists: false
      }
    },

    created () {
      this.loadIdea(this.ideaKey)
    },

    watch: {
      ideaKey (key) {
        this.loadIdea(key)
      }
    },

    methods: {
      loadIdea (key) {
        this.loading = true
        this.exists = false

        this.$store.dispatch('idea/load', key)
          .then((result) => {
            if (result.exists) {
              this.exists = true
            }
            this.loading = false
          })
          .catch((err) => {
            if (err) {
              console.error(err)
            }

            this.loading = false
          })
      }
    },

    computed: {
      idea () {
        return this.$store.getters['idea/get'](this.ideaKey)
      }
    }
  }
</script>

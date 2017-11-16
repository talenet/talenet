<template>
  <div v-if="mode === 'view'">
    <div v-if="loading">
      <t-loading-animation></t-loading-animation>
    </div>

    <div v-if="!loading && !exists">
      <h1>{{$t('idea.error.notFound')}}</h1>
    </div>

    <div v-if="!loading && exists">
      <h1>{{idea.title()}}</h1>

      <t-markdown-text :text="idea.description()"></t-markdown-text>

      <div>
        <b-button variant="secondary" @click="editIdea">{{$t('idea.view.edit.button')}}</b-button>
      </div>
    </div>
  </div>
  <div v-else><!-- mode === 'edit' -->
    <t-idea-edit-form
      :ideaKey="ideaKey"
      @save="ideaSaved"
      @cancel="editCanceled"
    ></t-idea-edit-form>
  </div>
</template>

<script>
  export default {
    props: [
      'ideaKey'
    ],

    data () {
      return {
        mode: 'view',
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
      },

      editIdea () {
        this.mode = 'edit'
      },

      ideaSaved () {
        this.mode = 'view'
        this.loadIdea(this.ideaKey)
        // TODO: Feedback
      },

      editCanceled () {
        this.mode = 'view'
      }
    },

    computed: {
      idea () {
        return this.$store.getters['idea/get'](this.ideaKey)
      }
    }
  }
</script>

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
        <strong>TODO: Label for hats</strong>

        <div class="row">
          <div class="col-md-6" v-for="hatKey in hats">
             <t-identity-card :identityKey="hatKey"></t-identity-card>
          </div>
        </div>
      </div>

      <div>
        <b-button v-if="idea.hasHat(ownIdentityKey)" variant="secondary" @click="editIdea">
          {{$t('idea.view.edit.button')}}
        </b-button>
        <b-button v-if="!idea.isHatTaken()" variant="outline-success" @click="takeHat">
          {{$t('idea.view.takeHat.button')}}
        </b-button>
        <b-button v-if="idea.hasHat(ownIdentityKey)" variant="warning" @click="discardHat">
          {{$t('idea.view.discardHat.button')}}
        </b-button>
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
  import { mapGetters } from 'vuex'

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
      },

      _updateHat (action) {
        this.loading = true

        this.$store.dispatch('idea/' + action, this.ideaKey)
          .then(() => {
            this.loadIdea(this.ideaKey)
          })
          .catch((err) => {
            if (err) {
              console.error(err)
            }

            this.loading = false
          })
      },

      takeHat () {
        this._updateHat('takeHat')
      },

      discardHat () {
        this._updateHat('discardHat')
      }
    },

    computed: {
      ...mapGetters({
        ownIdentityKey: 'ssb/whoami' // TODO: Refactor ssb module?
      }),

      idea () {
        return this.$store.getters['idea/get'](this.ideaKey)
      },

      hats () {
        return this.$store.getters['idea/get'](this.ideaKey).hats()
      }
    }
  }
</script>

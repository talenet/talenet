<template>
  <div class="row">
    <div class="t-center-col">
      <p>Some messages</p>
      <t-message-thread-card v-for="msg in messages"
        :message="msg">
      </t-message-thread-card>

      <p><strong>WIP</strong>(private) note to self</p>
      <b-form-textarea v-model="noteToSelf"></b-form-textarea>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'privateMessages/subscribeAll'
        ]
      })
    ],

    computed: {
      ...mapGetters({
        'messages': 'privateMessages/all'
      })
    },

    data () {
      return {
        noteToSelf: ''
      }
    }
  }
</script>

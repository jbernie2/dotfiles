// Copyright 2022 beekeeb
// SPDX-License-Identifier: GPL-2.0-or-later

#include QMK_KEYBOARD_H


#define MT_G(kc) MT(MOD_LGUI, kc)
#define MT_A(kc) MT(MOD_LALT, kc)
#define MT_C(kc) MT(MOD_LCTL, kc)
#define MT_S(kc) MT(MOD_LSFT, kc)
#define MT_H(kc) MT(MOD_HYPR, kc)

#include "g/keymap_combo.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
     /*
      * ┌───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┐
      * │ Q │ W │ E │ R │ T │       │ Y │ U │ I │ O │ P │
      * ├───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┤
      * │ A │ S │ D │ F │ G │       │ H │ J │ K │ L │ ' │
      * ├───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┤
      * │ Z │ X │ C │ V │ B │       │ N │ M │ , │ . │ / │
      * └───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┘
      *           ┌───┐                   ┌───┐
      *           │Esc├───┐           ┌───┤Del│
      *           └───┤Spc├───┐   ┌───┤Bsp├───┘
      *               └───┤Tab│   │Ent├───┘
      *                   └───┘   └───┘
      */
    [0] = LAYOUT_split_3x6_3(
        KC_NO,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                      KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_NO,
        KC_NO,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                      KC_H,    KC_J,    KC_K,    KC_L,    KC_QUOT, KC_NO,
        KC_NO,  KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                      KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_NO,
                LT(3,KC_ESC),     LT(1,KC_SPC),     LT(2,KC_TAB),      LT(5,KC_ENT),    LT(4,KC_BSPC),    LT(6,KC_DEL)
    ),

    [1] = LAYOUT_split_3x6_3(
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT,CW_TOGG, KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_HOME, KC_PGDN, KC_PGUP, KC_END,  KC_CAPS, KC_NO,
                                  KC_NO,   KC_NO,   KC_NO,                     KC_ENT, KC_BSPC,  KC_DEL
    ),

    [2] = LAYOUT_split_3x6_3(
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_NO,   KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_WH_R, KC_WH_U, KC_WH_D, KC_WH_L, KC_NO,   KC_NO,
                                  KC_NO,   KC_NO,   KC_NO,                     KC_BTN2, KC_BTN1, KC_BTN3
    ),

    [3] = LAYOUT_split_3x6_3(
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, KC_NO,   KC_NO,
        KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,                     KC_NO,   KC_MUTE, KC_NO,   KC_NO,   KC_NO,   KC_NO,
                                  KC_NO,   KC_NO,   KC_NO,                     KC_MSTP, KC_MPLY, KC_DEL
    ),

    [4] = LAYOUT_split_3x6_3(
        KC_NO,  KC_LBRC, KC_7,    KC_8,    KC_9,    KC_RBRC,                   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_SCLN, KC_4,    KC_4,    KC_5,    KC_EQL,                    KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_GRV,  KC_1,    KC_2,    KC_3,    KC_BSLS,                   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
                                  KC_DOT,  KC_0,    KC_MINS,                   KC_NO,   KC_NO,   KC_NO
    ),

    [5] = LAYOUT_split_3x6_3(
        KC_NO,  KC_LCBR, KC_AMPR, KC_ASTR, KC_LPRN, KC_RCBR,                   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_COLN, KC_DLR,  KC_PERC, KC_CIRC, KC_PLUS,                   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_TILD, KC_EXLM, KC_AT,   KC_HASH, KC_PIPE,                   KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
                                  KC_LPRN, KC_RPRN, KC_UNDS,                   KC_NO,  KC_NO,   KC_NO
    ),

    [6] = LAYOUT_split_3x6_3(
        KC_NO,  KC_F12,  KC_F7,   KC_F8,   KC_F9,   KC_NO,                     KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_F11,  KC_F4,   KC_F5,   KC_F6,   KC_NO,                     KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
        KC_NO,  KC_F10,  KC_F1,   KC_F2,   KC_F3,   KC_NO,                     KC_NO,  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,
                                  KC_NO,   KC_NO,   KC_NO,                     KC_NO,  KC_NO,   KC_NO
    )

};

bool get_hold_on_other_key_press(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LT(4, KC_BSPC):
        case LT(5, KC_ENT):
            return true;
        default:
            return false;
    }
}

bool get_tapping_force_hold(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LT(4, KC_BSPC):
        case LT(5, KC_ENT):
            return true;
        default:
            return false;
    }
}

bool caps_word_press_user(uint16_t keycode) {
    switch (keycode) {
        // Keycodes that continue Caps Word, with shift applied.
        case KC_A ... KC_Z:
            add_weak_mods(MOD_BIT(KC_LSFT));  // Apply shift to next key.
            return true;

        // Keycodes that continue Caps Word, without shifting.
        case KC_1 ... KC_0:
        case KC_BSPC:
        case KC_DEL:
        case KC_UNDS:
        case KC_MINS:
            return true;

        default:
            return false;  // Deactivate Caps Word.
    }
}

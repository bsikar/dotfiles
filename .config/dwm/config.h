/* See LICENSE file for copyright and license details. */

/* Constants */
/* appearance */
static const unsigned int borderpx  = 50;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 0;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 0;       /* vert inner gap between windows */
static const unsigned int gappoh    = 0;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 0;       /* vert outer gap between windows and screen edge */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Iosevka Extended:size=16"  };
static char dmenufont[]             = "Iosevka Extended:size=16";

static char normbgcolor[]           = "#282828";
static char normbordercolor[]       = "#282828";
static char normfgcolor[]           = "#564F4F";
static char selfgcolor[]            = "#564F4F";
static char selbordercolor[]        = "#282828";
static char selbgcolor[]            = "#282828";

static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

typedef struct {
    const char *name;
    const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {"st", "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm",      spcmd1},
    {"spranger",    spcmd2},
};
/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *  WM_CLASS(STRING) = instance, class
     *  WM_NAME(STRING) = title
    */
    /* class    instance      title          tags mask    isfloating   isterminal  noswallow  monitor */
    { "St",     NULL,       "st",              1 << 8,       0,           0,         0,        -1 },
};


/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",    tile },         /* Default: Master on left, slaves on right */
    { "TTT",    bstack },       /* Master on top, slaves on bottom */

    { "[@]",    spiral },       /* Fibonacci spiral */
    { "[\\]",   dwindle },      /* Decreasing in size right and leftward */

    { "H[]",    deck },         /* Master on left, slaves in monocle-like mode on right */
    { "[M]",    monocle },      /* All windows on top of eachother */

    { "|M|",    centeredmaster },       /* Master in middle, slaves on sides */
    { ">M>",    centeredfloatingmaster },   /* Same but master floats */

    { "><>",    NULL },         /* no layout function means floating behavior */
    { NULL,     NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
    { MOD,  XK_j,   ACTION##stack,  {.i = INC(+1) } }, \
    { MOD,  XK_k,   ACTION##stack,  {.i = INC(-1) } }, \
    { MOD,  XK_v,   ACTION##stack,  {.i = 0 } }, \
    /* { MOD, XK_grave, ACTION##stack, {.i = PREVSEL } }, \ */
    /* { MOD, XK_a,     ACTION##stack, {.i = 1 } }, \ */
    /* { MOD, XK_z,     ACTION##stack, {.i = 2 } }, \ */
    /* { MOD, XK_x,     ACTION##stack, {.i = -1 } }, */

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd1[] = { "xfce4-terminal", NULL };
static const char *termcmd2[] = { "st", NULL };
static const char *brave[] = { "brave", NULL };
static const char *librewolf[] = { "librewolf", NULL };
static const char *tor[] = { "torbrowser-launcher", NULL };
static const char *code[] = { "code", NULL };
static const char *discord[] = { "discord", NULL };
static const char *helvum[] = { "helvum", NULL };
static const char *pavucontrol[] = { "pavucontrol", NULL };
static const char *torch[] = { "noisetorch", NULL };
static const char *snip[] = { "flameshot", "gui", NULL };
static const char *spotify[] = { "spotify", NULL };
static const char *mail[] = { "tutanota-desktop", NULL };

#include <X11/XF86keysym.h>
#include "shiftview.c"
static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,           XK_0,       view,       {.ui = ~0 } },
    { MODKEY|ShiftMask,     XK_0,       tag,        {.ui = ~0 } },
    { MODKEY|ShiftMask,         XK_b,       spawn,          {.v = librewolf } },
    { MODKEY|ShiftMask|ControlMask,         XK_b,       spawn,          {.v = tor } },
    { MODKEY|ControlMask,         XK_b,       spawn,          {.v = brave } },
    { MODKEY,         XK_c,       spawn,          {.v = code } },

    { MODKEY,           XK_Tab,     view,       {0} },
    { MODKEY,           XK_q,       killclient, {0} },
    { MODKEY,           XK_o,       incnmaster,     {.i = +1 } },
    { MODKEY|ShiftMask,     XK_o,       incnmaster,     {.i = -1 } },
    { MODKEY,           XK_backslash,       view,       {0} },
    { MODKEY,           XK_a,       togglegaps, {0} },
    { MODKEY|ShiftMask,     XK_a,       defaultgaps,    {0} },
    { MODKEY,           XK_s,       togglesticky,   {0} },
    { MODKEY,           XK_d,       spawn,          {.v = dmenucmd } },
    { MODKEY|ShiftMask,         XK_d,       spawn,          {.v = discord } },
    { MODKEY,           XK_p,       spawn,          {.v = snip } },
    { MODKEY|ShiftMask,         XK_p,       spawn,          {.v = helvum } },
    { MODKEY|ControlMask,         XK_p,       spawn,          {.v = torch } },
    { MODKEY|ShiftMask|ControlMask,         XK_p,       spawn,          {.v = pavucontrol } },
    { MODKEY|ShiftMask,         XK_s,       spawn,          {.v = spotify } },
    { MODKEY|ShiftMask,         XK_n,       spawn,          {.v = mail } },
    { MODKEY,           XK_f,       togglefullscr,  {0} },
    { MODKEY|ShiftMask,     XK_f,       setlayout,  {.v = &layouts[8]} },
    { MODKEY,           XK_g,       shiftview,  { .i = -1 } },
    { MODKEY|ShiftMask,     XK_g,       shifttag,   { .i = -1 } },
    { MODKEY,           XK_h,       setmfact,   {.f = -0.05} },
    /* J and K are automatically bound above in STACKEYS */
    { MODKEY,           XK_l,       setmfact,       {.f = +0.05} },
    { MODKEY,           XK_semicolon,   shiftview,  { .i = 1 } },
    { MODKEY|ShiftMask,     XK_semicolon,   shifttag,   { .i = 1 } },
    { MODKEY,           XK_Return,  spawn,      {.v = termcmd1 } },
    { MODKEY|ShiftMask,           XK_Return,  spawn,      {.v = termcmd2 } },
    { MODKEY,           XK_z,       incrgaps,   {.i = +3 } },
    { MODKEY|ShiftMask,         XK_z,       incrgaps,   {.i = -3 } },
    /* V is automatically bound above in STACKKEYS */
    { MODKEY,           XK_b,       togglebar,  {0} },
    /* { MODKEY,            XK_space,   zoom,       {0} }, */
    { MODKEY|ShiftMask,     XK_space,   togglefloating, {0} },
    { MODKEY,           XK_Left,    focusmon,   {.i = -1 } },
    { MODKEY|ShiftMask,     XK_Left,    tagmon,     {.i = -1 } },
    { MODKEY,           XK_Right,   focusmon,   {.i = +1 } },
    { MODKEY|ShiftMask,     XK_Right,   tagmon,     {.i = +1 } },
    { MODKEY,           XK_Page_Up, shiftview,  { .i = -1 } },
    { MODKEY|ShiftMask,     XK_Page_Up, shifttag,   { .i = -1 } },
    { MODKEY,           XK_Page_Down,   shiftview,  { .i = +1 } },
    { MODKEY|ShiftMask,     XK_Page_Down,   shifttag,   { .i = +1 } },

    { MODKEY,           XK_t,       setlayout,  {.v = &layouts[0]} }, // tile
    { MODKEY|ShiftMask,     XK_t,       setlayout,  {.v = &layouts[1]} }, // bstack
    { MODKEY|ControlMask,     XK_t,       setlayout,  {.v = &layouts[6]} }, // centeredmaster
    { MODKEY,           XK_y,       setlayout,  {.v = &layouts[2]} }, // spiral
    { MODKEY|ShiftMask,     XK_y,       setlayout,  {.v = &layouts[3]} }, // dwindle

    //{ MODKEY,           XK_u,       setlayout,  {.v = &layouts[4]} }, // deck
    //{ MODKEY|ShiftMask,     XK_u,       setlayout,  {.v = &layouts[5]} }, // monocle
    //{ MODKEY,           XK_i,       setlayout,  {.v = &layouts[6]} }, // centeredmaster
    //{ MODKEY|ShiftMask,     XK_i,       setlayout,  {.v = &layouts[7]} }, // centeredfloatingmaster

    { 0, XF86XK_AudioMute,      spawn,      SHCMD("pamixer -t") },
    { 0, XF86XK_AudioRaiseVolume,   spawn,      SHCMD("pamixer -i 5") },
    { 0, XF86XK_AudioLowerVolume,   spawn,      SHCMD("pamixer -d 5") },
    { 0, XF86XK_AudioPrev,      spawn,      SHCMD("playerctl previous") },
    { 0, XF86XK_AudioNext,      spawn,      SHCMD("playerctl next") },
    { 0, XF86XK_AudioPause,     spawn,      SHCMD("playerctl play-pause") },
    { 0, XF86XK_AudioPlay,      spawn,      SHCMD("playerctl play-pause") },
    { 0, XF86XK_AudioMicMute,   spawn,      SHCMD("amixer -c 0 set Capture toggle") },
    STACKKEYS(MODKEY,                          focus)
    STACKKEYS(MODKEY|ShiftMask,                push)
    TAGKEYS(            XK_1,       0)
    TAGKEYS(            XK_2,       1)
    TAGKEYS(            XK_3,       2)
    TAGKEYS(            XK_4,       3)
    TAGKEYS(            XK_5,       4)
    TAGKEYS(            XK_6,       5)
    TAGKEYS(            XK_7,       6)
    TAGKEYS(            XK_8,       7)
    TAGKEYS(            XK_9,       8)
    { MODKEY|ShiftMask,     XK_e,   quit,   {0} },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
#ifndef __OpenBSD__
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
    { ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
    { ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
    { ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
    { ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
    { ClkStatusText,        ShiftMask,      Button1,        sigdwmblocks,   {.i = 6} },
#endif
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        defaultgaps,    {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkClientWin,     MODKEY,     Button4,    incrgaps,   {.i = +1} },
    { ClkClientWin,     MODKEY,     Button5,    incrgaps,   {.i = -1} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkTagBar,        0,      Button4,    shiftview,  {.i = -1} },
    { ClkTagBar,        0,      Button5,    shiftview,  {.i = 1} },
    { ClkRootWin,       0,      Button2,    togglebar,  {0} },
};

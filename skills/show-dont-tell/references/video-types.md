# Video types

Each format below lists what it's for, the beats that usually work, a length, the visual
techniques that suit it, and a sample request. Lengths are starting points; cut anything
the viewer wouldn't miss.

## Concept explainer

**For:** making an idea click. How a system works, why an approach is better, what a
term means. Great for understanding your own codebase or a new domain.

**Beats:** a puzzle or question, a concrete example, the visual build-up, the general
rule, the payoff ("so that's why...").

**Length:** 45 s to 2 min.

**Visuals:** objects that morph from one state to the next instead of cutting (the
continuity carries the meaning), one fixed color per concept, terms revealed one at a
time, diagrams that build one step per sentence. Manim for math and algorithms; Remotion
or HyperFrames for systems and product concepts.

**Ask like:** "Make a 60-second explainer of how our job queue retries failed tasks,
built from the code in `src/queue`. Narrated, 16:9."

## Plan or proposal walkthrough

**For:** alignment or a decision before a meeting, so the meeting can be about the
decision instead of the explanation.

**Beats (SCQA, answer first):** the situation, what changed or what's broken, the
question, the recommendation, three supporting reasons, timeline and cost, the ask.

**Length:** 90 s to 3 min.

**Visuals:** progressive builds, a timeline that draws itself, one highlighted number per
scene, before and after states, the research or data that backs each reason.

**Ask like:** "Turn this plan into a two-minute video I can send before Thursday's call.
Lead with the recommendation, show the three options we rejected and why."

## Feature demo or PR video

**For:** proving that software works and showing what changed. A reviewer watches it
instead of checking out the branch.

**Beats:** the before state, the action, the result, one supporting detail (edge case,
test, metric), where to find it.

**Length:** 20 s per feature; 60 to 90 s for a walkthrough of a larger change.

**Visuals:** the real app recorded with Playwright, a smooth synthetic cursor, click
ripples, zoom into the area that changed, a short caption per step, the diff or test
output when it helps. See [screen-demos.md](screen-demos.md).

**Ask like:** "After QA passes, record the new invoice export flow on localhost, zoom on
the new button and the downloaded file, narrate it in under 60 seconds, and attach it
to the PR."

## Update or status video

**For:** replacing the part of a standup or review call where someone shares their
screen and talks for five minutes.

**Beats:** what I set out to do, what's done (shown, not listed), what's blocked or
decided, what's next, what I need from you.

**Length:** 60 s to 2 min.

**Visuals:** short clips of the work, a progress map, a single "ask" card at the end.

## Launch or announcement film

**For:** selling one promise with energy, internally or externally.

**Beats:** a cold open on the tension or the result, the name and the promise, three
moments of evidence, a fast montage of secondary features, the wordmark and the call to
action.

**Length:** 30 to 90 s.

**Visuals:** a restrained palette with one accent color, kinetic type locked to the
music, near-invisible cuts, macro shots of real UI, cuts on the beat.

## UGC-style or social clip

**For:** a hook-first vertical clip that survives muted autoplay in a feed.

**Beats:** a hook in under three seconds, the problem, the product in use, proof, a
specific call to action.

**Length:** 15 to 45 s, vertical 9:16.

**Visuals:** burned-in captions, faces or hands when available, product in context,
safe zones for platform UI (keep content between roughly 300 px and 1580 px from the top
at 1080 by 1920). Test variations of the hook, not the whole video.

## Data story

**For:** making one number matter.

**Beats:** the claim or question, the baseline, the reveal (build the chart one series at
a time), why it happened, so what.

**Length:** 30 to 90 s.

**Visuals:** animated chart builds, direct labels instead of legends, the accent color
only on the key point.

## Tutorial

**For:** teaching someone to do a task.

**Beats:** show the end result first, prerequisites, numbered steps with one action
each, a recap, the next step.

**Length:** 2 to 5 min.

**Visuals:** screen capture with zoom on the active area, a step counter, captions.

## Formats that mix

Most strong videos combine formats: a concept explainer section inside a plan
walkthrough, a screen-recorded demo inside a launch film. Keep one promise for the whole
video and let each scene borrow the technique that suits it.

## When to make an interactive page instead

Choose an HTML artifact when the viewer needs to explore at their own pace: compare
options, filter data, click through a prototype, or read details on demand. Video is
better for a guided story, for proof that something works, and for anything that
should be watched together in a meeting. Often the best answer is both: a short video at
the top of a page that holds the details.

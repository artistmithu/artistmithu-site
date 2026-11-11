-- 012: a show can carry its own short video file (stored in the artworks bucket), shown instead of YouTube.
alter table exhibitions add column if not exists video_path text;
-- 2026-11-11: transparent-boundary-2013 video_path set; site_content studio_video, process_video added.
-- 2026-11-11: process caption says seven sessions.

// ---- FNV Hash bd01586dc31416d6

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState Sampler1_s : register(s0);
Texture2D<float4> RenderTarget512 : register(t0);
Texture2D<float4> RenderTarget256 : register(t1);
Texture2D<float4> RenderTarget128 : register(t2);
Texture2D<float4> RenderTarget64 : register(t3);
Texture2D<float4> RenderTarget32 : register(t4);
Texture2D<float4> RenderTarget16 : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = float4(256,256,128,128) * v1.xyxy;
  r0.xyzw = frac(r0.xyzw);
  r1.xyzw = float4(-1,-1,-1,-1) + r0.xyzw;
  r0.xyzw = r0.xyzw * r1.xyzw + float4(0.5,0.5,0.5,0.5);
  r1.xyzw = -r0.zxyw * float4(0.0078125,0.00390625,0.00390625,0.0078125) + v1.xxyy;
  r0.xyzw = r0.xyzw * float4(0.00390625,0.00390625,0.0078125,0.0078125) + v1.xyxy;
  r2.xyz = RenderTarget256.Sample(Sampler1_s, r1.yz).xyz;
  r3.xw = r1.yz;
  r3.yz = r0.yx;
  r4.xyz = RenderTarget256.Sample(Sampler1_s, r3.xy).xyz;
  r3.xyz = RenderTarget256.Sample(Sampler1_s, r3.zw).xyz;
  r2.xyz = r4.xyz + r2.xyz;
  r4.xyz = RenderTarget256.Sample(Sampler1_s, r0.xy).xyz;
  r2.xyz = r4.xyz + r2.xyz;
  r2.xyz = r2.xyz + r3.xyz;
  r2.xyz = v2.yyy * r2.xyz;
  r2.xyz = float3(0.25,0.25,0.25) * r2.xyz;
  r3.xyz = RenderTarget512.Sample(Sampler1_s, v1.xy).xyz;
  r2.xyz = r3.xyz * v2.xxx + r2.xyz;
  r3.xyz = RenderTarget128.Sample(Sampler1_s, r1.xw).xyz;
  r1.yz = r0.wz;
  r0.xyz = RenderTarget128.Sample(Sampler1_s, r0.zw).xyz;
  r4.xyz = RenderTarget128.Sample(Sampler1_s, r1.xy).xyz;
  r1.xyz = RenderTarget128.Sample(Sampler1_s, r1.zw).xyz;
  r3.xyz = r4.xyz + r3.xyz;
  r0.xyz = r3.xyz + r0.xyz;
  r0.xyz = r0.xyz + r1.xyz;
  r0.xyz = v2.zzz * r0.xyz;
  r0.xyz = r0.xyz * float3(0.25,0.25,0.25) + r2.xyz;
  r1.xyzw = float4(64,64,32,32) * v1.xyxy;
  r1.xyzw = frac(r1.xyzw);
  r2.xyzw = float4(-1,-1,-1,-1) + r1.xyzw;
  r1.xyzw = r1.xyzw * r2.xyzw + float4(0.5,0.5,0.5,0.5);
  r2.xyzw = -r1.zxyw * float4(0.03125,0.015625,0.015625,0.03125) + v1.xxyy;
  r1.xyzw = r1.xyzw * float4(0.015625,0.015625,0.03125,0.03125) + v1.xyxy;
  r3.xyz = RenderTarget64.Sample(Sampler1_s, r2.yz).xyz;
  r4.xw = r2.yz;
  r4.yz = r1.yx;
  r5.xyz = RenderTarget64.Sample(Sampler1_s, r4.xy).xyz;
  r4.xyz = RenderTarget64.Sample(Sampler1_s, r4.zw).xyz;
  r3.xyz = r5.xyz + r3.xyz;
  r5.xyz = RenderTarget64.Sample(Sampler1_s, r1.xy).xyz;
  r3.xyz = r5.xyz + r3.xyz;
  r3.xyz = r3.xyz + r4.xyz;
  r3.xyz = v2.www * r3.xyz;
  r0.xyz = r3.xyz * float3(0.25,0.25,0.25) + r0.xyz;
  r3.xyz = RenderTarget32.Sample(Sampler1_s, r2.xw).xyz;
  r2.yz = r1.wz;
  r1.xyz = RenderTarget32.Sample(Sampler1_s, r1.zw).xyz;
  r4.xyz = RenderTarget32.Sample(Sampler1_s, r2.xy).xyz;
  r2.xyz = RenderTarget32.Sample(Sampler1_s, r2.zw).xyz;
  r3.xyz = r4.xyz + r3.xyz;
  r1.xyz = r3.xyz + r1.xyz;
  r1.xyz = r1.xyz + r2.xyz;
  r1.xyz = v3.xxx * r1.xyz;
  r0.xyz = r1.xyz * float3(0.25,0.25,0.25) + r0.xyz;
  r1.xy = float2(16,16) * v1.xy;
  r1.xy = frac(r1.xy);
  r1.zw = float2(-1,-1) + r1.xy;
  r1.xy = r1.xy * r1.zw + float2(0.5,0.5);
  r2.xy = -r1.xy * float2(0.0625,0.0625) + v1.xy;
  r2.zw = r1.xy * float2(0.0625,0.0625) + v1.xy;
  r1.xyz = RenderTarget16.Sample(Sampler1_s, r2.xy).xyz;
  r3.xyz = RenderTarget16.Sample(Sampler1_s, r2.xw).xyz;
  r4.xyz = RenderTarget16.Sample(Sampler1_s, r2.zy).xyz;
  r2.xyz = RenderTarget16.Sample(Sampler1_s, r2.zw).xyz;
  r1.xyz = r3.xyz + r1.xyz;
  r1.xyz = r1.xyz + r2.xyz;
  r1.xyz = r1.xyz + r4.xyz;
  r1.xyz = v3.yyy * r1.xyz;
  r0.xyz = r1.xyz * float3(0.25,0.25,0.25) + r0.xyz;
  r0.w = dot(v2.xyzw, float4(1,1,1,1));
  r1.x = dot(v3.xyzw, float4(1,1,1,1));
  r0.w = r1.x + r0.w;
  r0.w = 1 / r0.w;
  r0.xyz = r0.xyz * r0.www;
  r0.xyz = max(float3(0,0,0), r0.xyz);
  o0.xyz = min(float3(32768,32768,32768), r0.xyz);
  o0.w = 1;
  return;
}
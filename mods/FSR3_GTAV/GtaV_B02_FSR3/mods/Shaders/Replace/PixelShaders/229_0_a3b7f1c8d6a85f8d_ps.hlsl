// ---- FNV Hash a3b7f1c8d6a85f8d

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer lighting_locals : register(b11)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState GBufferTextureSampler0Global_s : register(s7);
SamplerState GBufferTextureSampler1Global_s : register(s8);
SamplerState GBufferTextureSampler2Global_s : register(s9);
Texture2D<float4> GBufferTextureSampler0Global : register(t7);
Texture2D<float4> GBufferTextureSampler1Global : register(t8);
Texture2D<float4> GBufferTextureSampler2Global : register(t9);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v1.xy / v1.ww;
  r1.xyzw = GBufferTextureSampler1Global.Sample(GBufferTextureSampler1Global_s, r0.xy).xyzw;
  r2.xyz = float3(0.998046875,7.984375,63.875) * r1.www;
  r2.xyz = frac(r2.xyz);
  r2.xy = -r2.yz * float2(0.125,0.125) + r2.xy;
  r1.xyz = r1.xyz * float3(256,256,256) + r2.xyz;
  r1.xyz = float3(-128,-128,-128) + r1.xyz;
  r0.z = dot(r1.xyz, r1.xyz);
  r0.z = rsqrt(r0.z);
  r1.xyz = r1.xyz * r0.zzz;
  r2.xyz = v2.xyz / v2.www;
  r0.z = dot(r2.xyz, r2.xyz);
  r0.z = rsqrt(r0.z);
  r3.xyz = r2.xyz * r0.zzz;
  r2.xyz = -r2.xyz * r0.zzz + -deferredLightParams[1].xyz;
  r3.x = saturate(dot(-r3.xyz, r1.xyz));
  r0.z = dot(r2.xyz, r2.xyz);
  r0.z = rsqrt(r0.z);
  r2.xyz = r2.xyz * r0.zzz;
  r3.y = saturate(dot(r2.xyz, -deferredLightParams[1].xyz));
  r0.z = dot(r1.xyz, r2.xyz);
  r0.w = saturate(dot(r1.xyz, -deferredLightParams[1].xyz));
  r0.z = saturate(9.99999994e-09 + r0.z);
  r0.z = log2(r0.z);
  r1.xy = float2(1,1) + -r3.xy;
  r1.zw = r1.xy * r1.xy;
  r1.zw = r1.zw * r1.zw;
  r1.xy = r1.zw * r1.xy;
  r2.xyzw = GBufferTextureSampler2Global.Sample(GBufferTextureSampler2Global_s, r0.xy).xyzw;
  r3.xyzw = GBufferTextureSampler0Global.Sample(GBufferTextureSampler0Global_s, r0.xy).xyzw;
  r3.xyz = r3.xyz * r3.xyz;
  r0.x = 1 + -r2.z;
  r0.xy = r2.zz * r1.xy + r0.xx;
  r1.xy = r2.xy * r2.xy;
  r1.z = r1.y * 512 + -500;
  r1.z = max(0, r1.z);
  r1.y = r1.y * 512 + -r1.z;
  r1.z = 558 * r1.z;
  r1.y = r1.y * 3 + r1.z;
  r1.yz = float2(2,9.99999994e-09) + r1.yy;
  r1.x = min(1, r1.x);
  r0.z = r1.z * r0.z;
  r1.y = 0.125 * r1.y;
  r0.z = exp2(r0.z);
  r0.y = r0.z * r0.y;
  r0.x = -r1.x * r0.x + 1;
  r0.x = r0.w * r0.x;
  r0.y = r0.y * r1.y;
  r0.y = r0.y * r1.x;
  r0.y = r0.y * r0.w;
  r0.xyz = r3.xyz * r0.xxx + r0.yyy;
  r0.xyz = deferredLightParams[3].xyz * r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 1;
  return;
}
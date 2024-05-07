// ---- FNV Hash 394252f461785ff3

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

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

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

cbuffer lighting_locals : register(b12)
{
  float4 deferredLightParams[14] : packoffset(c0);
  float4 deferredLightVolumeParams[2] : packoffset(c14);
  float4 deferredLightScreenSize : packoffset(c16);
  float4 deferredProjectionParams : packoffset(c17);
  float3 deferredPerspectiveShearParams0 : packoffset(c18);
  float3 deferredPerspectiveShearParams1 : packoffset(c19);
  float3 deferredPerspectiveShearParams2 : packoffset(c20);
}

SamplerState gDeferredLightSampler2_s : register(s4);
SamplerComparisonState gShadowZSamplerCache_s : register(s14);
Texture2D<float4> gDeferredLightSampler2 : register(t4);
TextureCube<float4> gLocalLightShadowCM0 : register(t14);
Texture2D<float> gLocalLightShadowSpot0 : register(t24);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v2.xy / v2.ww;
  r1.xyzw = gDeferredLightSampler2.Sample(gDeferredLightSampler2_s, r0.xy).xyzw;
  r0.z = 1 + deferredProjectionParams.w;
  r0.z = r0.z + -r1.x;
  r0.z = deferredProjectionParams.z / r0.z;
  r1.xyz = -gViewInverse._m30_m31_m32 + v1.xyz;
  r2.xy = r0.xy * float2(2,-2) + float2(-1,1);
  r2.zw = float2(1,1);
  r3.x = dot(r2.xyz, deferredPerspectiveShearParams0.xyz);
  r3.y = dot(r2.xyz, deferredPerspectiveShearParams1.xyz);
  r3.z = dot(r2.xyz, deferredPerspectiveShearParams2.xyz);
  r0.xyw = r3.xyz * r0.zzz;
  r0.x = dot(r0.xyw, r0.xyw);
  r2.xyz = v3.xxx * r1.xyz;
  r4.xyz = v3.yyy * r1.xyz;
  r5.xyz = r1.xyz * v3.xxx + gViewInverse._m30_m31_m32;
  r6.xyz = v4.xyz * v2.zzz;
  r0.y = dot(r2.xyz, r2.xyz);
  r0.y = r0.x + -r0.y;
  r0.y = cmp(r0.y < 0);
  if (r0.y != 0) discard;
  r0.y = dot(r4.xyz, r4.xyz);
  r0.w = cmp(r0.x >= r0.y);
  r1.xyz = r1.xyz * v3.yyy + gViewInverse._m30_m31_m32;
  r2.xyz = r3.xyz * r0.zzz + gViewInverse._m30_m31_m32;
  r1.xyz = r0.www ? r1.xyz : r2.xyz;
  r0.y = r0.x / r0.y;
  r0.y = r0.w ? 1 : r0.y;
  r0.zw = floor(v0.yx);
  r0.zw = float2(0.333333343,0.333333343) * r0.zw;
  r0.zw = frac(r0.zw);
  r0.zw = float2(3,9) * r0.zw;
  r0.z = r0.w + r0.z;
  r1.xyz = r1.xyz + -r5.xyz;
  r2.xyz = r1.xyz * r0.zzz;
  r2.xyz = r2.xyz * float3(0.0140845068,0.0140845068,0.0140845068) + r5.xyz;
  r3.xyz = deferredLightParams[0].xyz + -r2.xyz;
  r0.z = dot(r3.xyz, r3.xyz);
  r0.w = cmp(0 < r0.z);
  r1.w = sqrt(r0.z);
  r1.w = 1 / r1.w;
  r3.xyz = r3.xyz * r1.www;
  r0.z = saturate(-r0.z * deferredLightParams[4].z + 1);
  r1.w = 1 + -deferredLightParams[7].x;
  r3.w = r1.w * r0.z + deferredLightParams[7].x;
  r0.z = r0.z / r3.w;
  r3.x = dot(r3.xyz, -deferredLightParams[1].xyz);
  r3.x = saturate(r3.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r0.z = r3.x * r0.z;
  r2.w = dot(r2.xyzw, deferredLightParams[6].xyzw);
  r2.w = cmp(r2.w >= 0);
  r2.w = r2.w ? 1.000000 : 0;
  r0.z = r2.w * r0.z;
  r0.z = r0.w ? r0.z : 0;
  r3.xyz = -gViewInverse._m30_m31_m32 + r2.xyz;
  r0.w = dot(r3.xyz, r3.xyz);
  r2.w = cmp(gLocalLightShadowData[0]._m03 == 3.000000);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r3.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r3.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r3.ww;
    r3.w = dot(r4.xyz, r4.xyz);
    r3.w = sqrt(r3.w);
    r5.z = gLocalLightShadowData[0]._m23 * r3.w;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r3.w = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r3.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r3.xyz;
    r4.x = dot(r3.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r4.y = dot(r3.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.z = dot(r3.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r3.xyz = -r4.xyz;
    r4.x = dot(r3.xyz, r3.xyz);
    r4.x = sqrt(r4.x);
    r4.x = gLocalLightShadowData[0]._m23 * r4.x;
    r3.w = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r3.xyz, r4.x).x;
  }
  r0.z = r3.w * r0.z;
  r0.w = cmp(r0.x >= r0.w);
  r0.z = r0.w ? r0.z : 0;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r2.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r4.x = cmp(0 < r0.w);
  r4.y = sqrt(r0.w);
  r4.y = 1 / r4.y;
  r2.xyz = r4.yyy * r2.xyz;
  r0.w = saturate(-r0.w * deferredLightParams[4].z + 1);
  r4.y = r1.w * r0.w + deferredLightParams[7].x;
  r0.w = r0.w / r4.y;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r0.w = r2.x * r0.w;
  r3.w = 1;
  r2.x = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.x = cmp(r2.x >= 0);
  r2.x = r2.x ? 1.000000 : 0;
  r0.w = r2.x * r0.w;
  r0.w = r4.x ? r0.w : r0.z;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r4.x = dot(r2.xyz, r2.xyz);
  r4.y = cmp(0 < r4.x);
  r4.z = sqrt(r4.x);
  r4.z = 1 / r4.z;
  r2.xyz = r4.zzz * r2.xyz;
  r4.x = saturate(-r4.x * deferredLightParams[4].z + 1);
  r4.z = r1.w * r4.x + deferredLightParams[7].x;
  r4.x = r4.x / r4.z;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.x = r4.x * r2.x;
  r3.w = 1;
  r2.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r4.y ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r4.x = dot(r2.xyz, r2.xyz);
  r4.y = cmp(0 < r4.x);
  r4.z = sqrt(r4.x);
  r4.z = 1 / r4.z;
  r2.xyz = r4.zzz * r2.xyz;
  r4.x = saturate(-r4.x * deferredLightParams[4].z + 1);
  r4.z = r1.w * r4.x + deferredLightParams[7].x;
  r4.x = r4.x / r4.z;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.x = r4.x * r2.x;
  r3.w = 1;
  r2.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r4.y ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r4.x = dot(r2.xyz, r2.xyz);
  r4.y = cmp(0 < r4.x);
  r4.z = sqrt(r4.x);
  r4.z = 1 / r4.z;
  r2.xyz = r4.zzz * r2.xyz;
  r4.x = saturate(-r4.x * deferredLightParams[4].z + 1);
  r4.z = r1.w * r4.x + deferredLightParams[7].x;
  r4.x = r4.x / r4.z;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.x = r4.x * r2.x;
  r3.w = 1;
  r2.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r4.y ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r4.x = dot(r2.xyz, r2.xyz);
  r4.y = cmp(0 < r4.x);
  r4.z = sqrt(r4.x);
  r4.z = 1 / r4.z;
  r2.xyz = r4.zzz * r2.xyz;
  r4.x = saturate(-r4.x * deferredLightParams[4].z + 1);
  r4.z = r1.w * r4.x + deferredLightParams[7].x;
  r4.x = r4.x / r4.z;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.x = r4.x * r2.x;
  r3.w = 1;
  r2.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r4.y ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r2.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r4.x = dot(r2.xyz, r2.xyz);
  r4.y = cmp(0 < r4.x);
  r4.z = sqrt(r4.x);
  r4.z = 1 / r4.z;
  r2.xyz = r4.zzz * r2.xyz;
  r4.x = saturate(-r4.x * deferredLightParams[4].z + 1);
  r4.z = r1.w * r4.x + deferredLightParams[7].x;
  r4.x = r4.x / r4.z;
  r2.x = dot(r2.xyz, -deferredLightParams[1].xyz);
  r2.x = saturate(r2.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r2.x = r4.x * r2.x;
  r3.w = 1;
  r2.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r2.y = cmp(r2.y >= 0);
  r2.y = r2.y ? 1.000000 : 0;
  r2.x = r2.x * r2.y;
  r0.w = r4.y ? r2.x : r0.w;
  r2.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r3.w = dot(r2.xyz, r2.xyz);
  if (r2.w != 0) {
    r4.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r4.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r4.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r4.w = dot(r4.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r5.xy = r5.xy / -r4.ww;
    r4.x = dot(r4.xyz, r4.xyz);
    r4.x = sqrt(r4.x);
    r5.z = gLocalLightShadowData[0]._m23 * r4.x;
    r4.xyz = r5.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r4.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r4.xy, r4.z).x;
  } else {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r2.xyz;
    r5.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r5.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r5.z = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r2.xyz = -r5.xyz;
    r4.y = dot(r2.xyz, r2.xyz);
    r4.y = sqrt(r4.y);
    r4.y = gLocalLightShadowData[0]._m23 * r4.y;
    r4.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xyz, r4.y).x;
  }
  r0.w = r4.x * r0.w;
  r2.x = cmp(r0.x >= r3.w);
  r0.w = r2.x ? r0.w : 0;
  r0.z = r0.z + r0.w;
  r3.xyz = r1.xyz * float3(0.126760557,0.126760557,0.126760557) + r3.xyz;
  r1.xyz = deferredLightParams[0].xyz + -r3.xyz;
  r2.x = dot(r1.xyz, r1.xyz);
  r2.y = cmp(0 < r2.x);
  r2.z = sqrt(r2.x);
  r2.z = 1 / r2.z;
  r1.xyz = r2.zzz * r1.xyz;
  r2.x = saturate(-r2.x * deferredLightParams[4].z + 1);
  r1.w = r1.w * r2.x + deferredLightParams[7].x;
  r1.w = r2.x / r1.w;
  r1.x = dot(r1.xyz, -deferredLightParams[1].xyz);
  r1.x = saturate(r1.x * deferredLightParams[5].w + deferredLightParams[5].z);
  r1.x = r1.w * r1.x;
  r3.w = 1;
  r1.y = dot(r3.xyzw, deferredLightParams[6].xyzw);
  r1.y = cmp(r1.y >= 0);
  r1.y = r1.y ? 1.000000 : 0;
  r1.x = r1.x * r1.y;
  r0.w = r2.y ? r1.x : r0.w;
  r1.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  if (r2.w != 0) {
    r2.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r1.xyz;
    r3.x = dot(r2.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r3.y = dot(r2.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r2.w = dot(r2.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r3.xy = r3.xy / -r2.ww;
    r2.x = dot(r2.xyz, r2.xyz);
    r2.x = sqrt(r2.x);
    r3.z = gLocalLightShadowData[0]._m23 * r2.x;
    r2.xyz = r3.xyz * float3(0.5,-0.5,1) + float3(0.5,0.5,0.00100000005);
    r2.x = gLocalLightShadowSpot0.SampleCmpLevelZero(gShadowZSamplerCache_s, r2.xy, r2.z).x;
  } else {
    r1.xyz = gLocalLightShadowData[0]._m30_m31_m32 + r1.xyz;
    r3.x = dot(r1.xyz, gLocalLightShadowData[0]._m00_m01_m02);
    r3.y = dot(r1.xyz, gLocalLightShadowData[0]._m10_m11_m12);
    r3.z = dot(r1.xyz, gLocalLightShadowData[0]._m20_m21_m22);
    r1.xyz = -r3.xyz;
    r2.y = dot(r1.xyz, r1.xyz);
    r2.y = sqrt(r2.y);
    r2.y = gLocalLightShadowData[0]._m23 * r2.y;
    r2.x = gLocalLightShadowCM0.SampleCmpLevelZero(gShadowZSamplerCache_s, r1.xyz, r2.y).x;
  }
  r0.w = r2.x * r0.w;
  r0.x = cmp(r0.x >= r1.w);
  r0.x = r0.x ? r0.w : 0;
  r0.x = r0.z + r0.x;
  r0.x = r0.x * r0.y;
  r0.x = 0.125 * r0.x;
  r0.xyz = r6.xyz * r0.xxx;
  r0.w = saturate(v3.z / deferredLightVolumeParams[0].y);
  r0.xyz = r0.xyz * r0.www;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = 1;
  return;
}
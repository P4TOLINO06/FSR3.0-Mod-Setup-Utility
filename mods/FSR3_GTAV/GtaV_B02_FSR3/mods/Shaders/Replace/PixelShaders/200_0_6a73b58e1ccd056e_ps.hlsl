// ---- FNV Hash 6a73b58e1ccd056e

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

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer megashader_locals : register(b12)
{
  float specularFresnel : packoffset(c0);
  float bumpiness : packoffset(c0.y);
  float reflectivePower : packoffset(c0.z);
  float gMirrorDistortionAmount : packoffset(c0.w);
  float useTessellation : packoffset(c1);
  float HardAlphaBlend : packoffset(c1.y);
  float4 gMirrorBounds : packoffset(c2);
  float4 gMirrorDebugParams : packoffset(c3);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState BumpSampler_s : register(s2);
SamplerState FogRaySampler_s : register(s11);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> BumpSampler : register(t2);
Texture2D<float4> FogRaySampler : register(t11);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float3 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : SV_Position0,
  float4 v9 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
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

  r0.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = dot(r0.xy, r0.xy);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r0.w = max(0.00100000005, bumpiness);
  r0.xy = r0.xy * r0.ww;
  r1.xyz = v5.xyz * r0.yyy;
  r0.xyw = r0.xxx * v4.xyz + r1.xyz;
  r0.xyz = r0.zzz * v2.xyz + r0.xyw;
  r0.z = dot(r0.xyz, r0.xyz);
  r0.z = rsqrt(r0.z);
  r0.xy = r0.xy * r0.zz;
  r0.z = dot(v3.xyz, v3.xyz);
  r0.z = rsqrt(r0.z);
  r1.xyz = v3.xyz * r0.zzz;
  r0.z = saturate(dot(r1.xyz, v2.xyz));
  r0.z = 1 + -r0.z;
  r0.w = r0.z * r0.z;
  r0.w = r0.w * r0.w;
  r0.z = r0.w * r0.z;
  r0.w = 1 + -specularFresnel;
  r0.z = specularFresnel * r0.z + r0.w;
  r1.xy = v7.xy / v7.ww;
  r1.xy = gMirrorBounds.zw * r1.xy + gMirrorBounds.xy;
  r0.xy = gMirrorDistortionAmount * r0.xy;
  r0.xy = r0.xy * float2(0.001953125,0.00390625) + r1.xy;
  r1.xyzw = ReflectionSampler.Sample(ReflectionSampler_s, r0.xy).xyzw;
  r0.xyw = reflectivePower * r1.xyz;
  r0.z = v0.w * r0.z;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r0.z = r2.w * r0.z;
  if (gUseFogRay != 0) {
    r2.xyz = -gViewInverse._m30_m31_m32 + v6.xyz;
    r1.w = dot(r2.xyz, r2.xyz);
    r2.w = sqrt(r1.w);
    r3.x = -globalFogParams[0].x + r2.w;
    r3.x = max(0, r3.x);
    r2.w = r3.x / r2.w;
    r2.w = r2.z * r2.w;
    r3.y = globalFogParams[2].z * r2.w;
    r2.w = cmp(0.00999999978 < abs(r2.w));
    r3.z = -1.44269502 * r3.y;
    r3.z = exp2(r3.z);
    r3.z = 1 + -r3.z;
    r3.y = r3.z / r3.y;
    r2.w = r2.w ? r3.y : 1;
    r3.y = globalFogParams[1].w * r3.x;
    r2.w = r3.y * r2.w;
    r2.w = min(1, r2.w);
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = min(1, r2.w);
    r2.w = 1 + -r2.w;
    r3.y = globalFogParams[2].y * r2.w;
    r1.w = rsqrt(r1.w);
    r2.xyz = r2.xyz * r1.www;
    r1.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r2.x = saturate(dot(r2.xyz, globalFogParams[3].xyz));
    r2.x = log2(r2.x);
    r2.x = globalFogParams[3].w * r2.x;
    r2.x = exp2(r2.x);
    r2.y = -r2.w * globalFogParams[2].y + 1;
    r2.z = -globalFogParams[2].x + r3.x;
    r2.z = max(0, r2.z);
    r2.yz = globalFogParams[1].yx * r2.yz;
    r2.z = 1.44269502 * r2.z;
    r2.z = exp2(r2.z);
    r2.z = 1 + -r2.z;
    r2.z = saturate(r2.y * r2.z + r3.y);
    r2.w = -globalFogParams[1].z * r3.x;
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.xxx * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r3.xyz = r2.www * r3.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xyz;
    r2.xyw = r2.yyy * r4.xyz + r3.xyz;
    r1.w = cmp(0 < gGlobalFogIntensity);
    if (r1.w != 0) {
      r3.xy = globalScreenSize.zw * v8.xy;
      r3.xyzw = FogRaySampler.Sample(FogRaySampler_s, r3.xy).xyzw;
      r1.w = -1 + r3.x;
      r1.w = saturate(gGlobalFogIntensity * r1.w + 1);
    } else {
      r1.w = 1;
    }
    r2.xyw = r2.xyw * r1.www + -r0.xyw;
    r2.xyz = r2.zzz * r2.xyw + r0.xyw;
  } else {
    r3.xyz = -gViewInverse._m30_m31_m32 + v6.xyz;
    r1.w = dot(r3.xyz, r3.xyz);
    r2.w = sqrt(r1.w);
    r3.w = -globalFogParams[0].x + r2.w;
    r3.w = max(0, r3.w);
    r2.w = r3.w / r2.w;
    r2.w = r3.z * r2.w;
    r4.x = globalFogParams[2].z * r2.w;
    r2.w = cmp(0.00999999978 < abs(r2.w));
    r4.y = -1.44269502 * r4.x;
    r4.y = exp2(r4.y);
    r4.y = 1 + -r4.y;
    r4.x = r4.y / r4.x;
    r2.w = r2.w ? r4.x : 1;
    r4.x = globalFogParams[1].w * r3.w;
    r2.w = r4.x * r2.w;
    r2.w = min(1, r2.w);
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = min(1, r2.w);
    r2.w = 1 + -r2.w;
    r4.x = globalFogParams[2].y * r2.w;
    r1.w = rsqrt(r1.w);
    r3.xyz = r3.xyz * r1.www;
    r1.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r3.x = saturate(dot(r3.xyz, globalFogParams[3].xyz));
    r3.x = log2(r3.x);
    r3.x = globalFogParams[3].w * r3.x;
    r3.x = exp2(r3.x);
    r2.w = -r2.w * globalFogParams[2].y + 1;
    r2.w = globalFogParams[1].y * r2.w;
    r3.y = -globalFogParams[2].x + r3.w;
    r3.y = max(0, r3.y);
    r3.y = globalFogParams[1].x * r3.y;
    r3.y = 1.44269502 * r3.y;
    r3.y = exp2(r3.y);
    r3.y = 1 + -r3.y;
    r3.y = saturate(r2.w * r3.y + r4.x);
    r3.z = -globalFogParams[1].z * r3.w;
    r3.z = 1.44269502 * r3.z;
    r3.z = exp2(r3.z);
    r3.z = 1 + -r3.z;
    r4.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r4.xyz = r1.www * r4.xyz + globalFogColorE.xyz;
    r5.xyz = globalFogColor.xyz + -r4.xyz;
    r4.xyz = r3.xxx * r5.xyz + r4.xyz;
    r4.xyz = -globalFogColorN.xyz + r4.xyz;
    r3.xzw = r3.zzz * r4.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xzw;
    r3.xzw = r2.www * r4.xyz + r3.xzw;
    r1.xyz = -reflectivePower * r1.xyz + r3.xzw;
    r2.xyz = r3.yyy * r1.xyz + r0.xyw;
  }
  o0.xyz = globalScalars3.zzz * r2.xyz;
  r0.x = cmp(0.300000012 < r0.z);
  r0.x = r0.x ? 1.000000 : 0;
  o1.x = v1.z * r0.x;
  o0.w = r0.z;
  o2.x = r0.x;
  return;
}
// ---- FNV Hash 94b98e548804f0b7

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

cbuffer cable_locals : register(b11)
{
  float shader_radiusScale : packoffset(c0);
  float shader_fadeExponent : packoffset(c0.y);
  float shader_windAmount : packoffset(c0.z);
  float3 shader_cableDiffuse : packoffset(c1);
  float3 shader_cableDiffuse2 : packoffset(c2);
  float2 shader_cableAmbient : packoffset(c3);
  float shader_cableEmissive : packoffset(c3.z);
  row_major float4x4 gViewProj : packoffset(c4);
  float4 gCableParams[5] : packoffset(c8);
  float alphaTestValue : packoffset(c13);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : TEXCOORD0,
  float4 v1 : TEXCOORD1,
  float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float2 v5 : TEXCOORD5,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = globalScalars.x * v0.w;
  r0.y = saturate(0.666666687 * v5.y);
  r0.z = saturate(v5.y + -abs(v5.x));
  r0.z = -1 + r0.z;
  r0.y = r0.y * r0.z + 1;
  r0.x = r0.x * r0.y;
  r0.y = cmp(r0.x < alphaTestValue);
  if (r0.y != 0) discard;
  r0.y = saturate(v1.w * 2 + -1);
  r0.z = dot(v2.xyz, v2.xyz);
  r0.w = dot(v3.xyz, v3.xyz);
  r1.x = r0.z * r0.w;
  r1.x = cmp(9.99999994e-09 < r1.x);
  r0.z = rsqrt(r0.z);
  r1.yzw = v2.xyz * r0.zzz;
  r0.z = rsqrt(r0.w);
  r2.xyz = v3.xyz * r0.zzz;
  r0.z = -r0.y * r0.y + 1;
  r0.z = sqrt(r0.z);
  r2.xyz = r2.xyz * r0.zzz;
  r0.yzw = r1.yzw * r0.yyy + r2.xyz;
  r1.y = dot(r0.yzw, r0.yzw);
  r1.y = rsqrt(r1.y);
  r0.yzw = r1.yyy * r0.yzw;
  r0.yzw = r1.xxx ? r0.yzw : float3(0,0,1);
  r1.xy = globalScalars.zy * v1.xy;
  r2.xyz = v0.xyz * v0.xyz;
  r1.xy = r1.xy * r1.xy;
  r1.z = gLightNaturalAmbient0.w + r0.w;
  r1.z = gLightNaturalAmbient1.w * r1.z;
  r1.z = max(0, r1.z);
  r3.xyz = gLightArtificialExtAmbient0.xyz * r1.zzz + gLightArtificialExtAmbient1.xyz;
  r1.w = 1 + -globalScalars2.z;
  r4.xyz = gLightArtificialIntAmbient0.xyz * r1.zzz + gLightArtificialIntAmbient1.xyz;
  r4.xyz = globalScalars2.zzz * r4.xyz;
  r3.xyz = r3.xyz * r1.www + r4.xyz;
  r3.xyz = r3.xyz * r1.yyy;
  r1.yzw = gLightNaturalAmbient0.xyz * r1.zzz + gLightNaturalAmbient1.xyz;
  r4.x = gLightArtificialIntAmbient1.w;
  r4.y = gLightArtificialExtAmbient0.w;
  r4.z = gLightArtificialExtAmbient1.w;
  r0.y = saturate(dot(r4.xyz, r0.yzw));
  r0.yzw = gDirectionalAmbientColour.xyz * r0.yyy + r1.yzw;
  r0.yzw = r0.yzw * r1.xxx + r3.xyz;
  r1.xyz = v4.www * v0.xyz;
  r0.yzw = r0.yzw * r2.xyz + r1.xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + v4.xyz;
  r1.w = dot(r1.xyz, r1.xyz);
  r2.x = sqrt(r1.w);
  r2.y = -globalFogParams[0].x + r2.x;
  r2.y = max(0, r2.y);
  r2.x = r2.y / r2.x;
  r2.x = r2.x * r1.z;
  r2.z = globalFogParams[2].z * r2.x;
  r2.x = cmp(0.00999999978 < abs(r2.x));
  r2.w = -1.44269502 * r2.z;
  r2.w = exp2(r2.w);
  r2.w = 1 + -r2.w;
  r2.z = r2.w / r2.z;
  r2.x = r2.x ? r2.z : 1;
  r2.z = globalFogParams[1].w * r2.y;
  r2.x = r2.z * r2.x;
  r2.x = min(1, r2.x);
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = min(1, r2.x);
  r2.x = 1 + -r2.x;
  r2.z = globalFogParams[2].y * r2.x;
  r1.w = rsqrt(r1.w);
  r1.xyz = r1.xyz * r1.www;
  r1.w = saturate(dot(r1.xyz, globalFogParams[4].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[4].w * r1.w;
  r1.w = exp2(r1.w);
  r1.x = saturate(dot(r1.xyz, globalFogParams[3].xyz));
  r1.x = log2(r1.x);
  r1.x = globalFogParams[3].w * r1.x;
  r1.x = exp2(r1.x);
  r1.y = -r2.x * globalFogParams[2].y + 1;
  r1.z = -globalFogParams[2].x + r2.y;
  r1.z = max(0, r1.z);
  r1.yz = globalFogParams[1].yx * r1.yz;
  r1.z = 1.44269502 * r1.z;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.z = saturate(r1.y * r1.z + r2.z);
  r2.x = -globalFogParams[1].z * r2.y;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  r2.yzw = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.yzw = r1.www * r2.yzw + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.yzw;
  r2.yzw = r1.xxx * r3.xyz + r2.yzw;
  r2.yzw = -globalFogColorN.xyz + r2.yzw;
  r2.xyz = r2.xxx * r2.yzw + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r2.x;
  r3.y = globalFogColorE.w + -r2.y;
  r3.z = globalFogColorN.w + -r2.z;
  r1.xyw = r1.yyy * r3.xyz + r2.xyz;
  r1.xyw = r1.xyw + -r0.yzw;
  r0.yzw = r1.zzz * r1.xyw + r0.yzw;
  o0.xyz = globalScalars3.zzz * r0.yzw;
  o0.w = r0.x;
  return;
}
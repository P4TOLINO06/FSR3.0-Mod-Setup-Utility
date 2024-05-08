// ---- FNV Hash 456ec74604585ba2

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
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

cbuffer megashader_locals : register(b12)
{
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float3 specMapIntMask : packoffset(c1);
  float useTessellation : packoffset(c1.w);
  float HardAlphaBlend : packoffset(c2);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  float4 v4 : TANGENT0,
  out float4 o0 : COLOR0,
  out float4 o1 : COLOR1,
  out float4 o2 : TEXCOORD0,
  out float4 o3 : TEXCOORD1,
  out float4 o4 : TEXCOORD2,
  out float4 o5 : TEXCOORD3,
  out float4 o6 : TEXCOORD4,
  out float4 o7 : TEXCOORD5,
  out float4 o8 : TEXCOORD6,
  out float4 o9 : TEXCOORD7,
  out float4 o10 : TEXCOORD8,
  out float3 o11 : TEXCOORD9,
  out float4 o12 : SV_Position0,
  out float4 o13 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.w
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = gWorld._m10_m11_m12 * v0.yyy;
  r0.xyz = v0.xxx * gWorld._m00_m01_m02 + r0.xyz;
  r0.xyz = v0.zzz * gWorld._m20_m21_m22 + r0.xyz;
  r0.xyz = gWorld._m30_m31_m32 + r0.xyz;
  r1.xyzw = gWorldViewProj._m10_m11_m12_m13 * v0.yyyy;
  r1.xyzw = v0.xxxx * gWorldViewProj._m00_m01_m02_m03 + r1.xyzw;
  r1.xyzw = v0.zzzz * gWorldViewProj._m20_m21_m22_m23 + r1.xyzw;
  r1.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  r2.xyz = gViewInverse._m30_m31_m32 + -r0.xyz;
  r3.xyz = gWorld._m10_m11_m12 * v3.yyy;
  r3.xyz = v3.xxx * gWorld._m00_m01_m02 + r3.xyz;
  r3.xyz = v3.zzz * gWorld._m20_m21_m22 + r3.xyz;
  r0.w = dot(r3.xyz, r3.xyz);
  r0.w = rsqrt(r0.w);
  r3.xyz = r3.xyz * r0.www;
  r0.w = dot(r3.xyz, r2.xyz);
  r2.w = cmp(0 < r0.w);
  r0.w = cmp(r0.w < 0);
  r0.w = (int)r0.w + (int)-r2.w;
  r0.w = (int)r0.w;
  r3.xyz = r3.xyz * r0.www;
  r0.w = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = rsqrt(r2.w);
  r4.xyz = r3.xyz * r2.www;
  r0.w = globalScalars.y * r0.w;
  r3.w = dot(r2.xyz, r2.xyz);
  r3.w = rsqrt(r3.w);
  r5.xyz = r3.www * r2.xyz;
  r6.xyz = r2.xyz * r3.www + -gDirectionalLight.xyz;
  r4.w = dot(r6.xyz, r6.xyz);
  r4.w = rsqrt(r4.w);
  r6.xyz = r6.xyz * r4.www;
  r4.w = saturate(specularIntensityMult);
  r5.w = globalScalars.z * globalScalars.z;
  r0.w = r0.w * r0.w;
  r6.w = -500 + specularFalloffMult;
  r6.w = max(0, r6.w);
  r7.x = specularFalloffMult + -r6.w;
  r6.w = 558 * r6.w;
  r6.w = r7.x * 3 + r6.w;
  r7.x = dot(r4.xyz, -gDirectionalLight.xyz);
  r7.y = saturate(r7.x);
  r7.y = r7.y + -abs(r7.x);
  r7.x = v1.w * r7.y + abs(r7.x);
  r8.x = saturate(dot(r5.xyz, r4.xyz));
  r8.y = saturate(dot(r6.xyz, -gDirectionalLight.xyz));
  r7.yz = float2(1,1) + -r8.xy;
  r8.xy = r7.yz * r7.yz;
  r8.xy = r8.xy * r8.xy;
  r7.yz = r8.xy * r7.yz;
  r7.w = 1 + -specularFresnel;
  r7.yz = specularFresnel * r7.yz + r7.ww;
  r8.xy = float2(2,9.99999994e-09) + r6.ww;
  r8.x = 0.125 * r8.x;
  r8.z = max(v1.w, r7.y);
  r7.y = -1 + r7.y;
  r7.y = r8.z * r7.y + 1;
  r7.y = -r4.w * r7.y + 1;
  r6.x = dot(r4.xyz, r6.xyz);
  r6.x = saturate(9.99999994e-09 + r6.x);
  r6.x = log2(r6.x);
  r6.x = r8.y * r6.x;
  r6.x = exp2(r6.x);
  r6.x = r6.x * r7.z;
  r6.x = r6.x * r8.x;
  r6.x = r6.x * r4.w;
  r6.x = r6.x * r7.x;
  r6.y = r7.x * r7.y;
  o5.xyz = gDirectionalColour.xyz * r6.yyy;
  o6.xyz = gDirectionalColour.xyz * r6.xxx;
  r6.x = cmp(0 >= gNumForwardLights);
  if (r6.x == 0) {
    r6.y = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r9.xyz = gLightPositionAndInvDistSqr[0].xyz + -r0.xyz;
    r10.xyz = -gLightPositionAndInvDistSqr[0].xyz + r0.xyz;
    r6.z = dot(r10.xyz, gLightDirectionAndFalloffExponent[0].xyz);
    r7.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r6.z = saturate(r6.z / r7.x);
    r6.z = gLightColourAndCapsuleExtent[0].w * r6.z;
    r10.xyz = gLightDirectionAndFalloffExponent[0].xyz * r6.zzz + gLightPositionAndInvDistSqr[0].xyz;
    r10.xyz = r10.xyz + -r0.xyz;
    r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
    r6.y = dot(r9.xyz, r9.xyz);
    r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
    r6.z = dot(r9.xyz, r9.xyz);
    r6.z = rsqrt(r6.z);
    r9.xyz = r9.xyz * r6.zzz;
    r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[0].w + 1);
    r6.z = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r6.z = r6.z * r6.y + gLightDirectionAndFalloffExponent[0].w;
    r6.y = r6.y / r6.z;
    r6.z = dot(r9.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
    r6.z = saturate(r6.z * gLightConeScale[0] + gLightConeOffset[0]);
    r7.x = dot(r9.xyz, r4.xyz);
    r7.z = saturate(r7.x);
    r7.z = r7.z + -abs(r7.x);
    r7.x = v1.w * r7.z + abs(r7.x);
    r6.z = r7.x * r6.z;
    r7.x = r6.z * r6.y;
    r10.xyz = gLightColourAndCapsuleExtent[0].xyz * r7.xxx;
    r9.xyz = r2.xyz * r3.www + r9.xyz;
    r7.x = dot(r9.xyz, r9.xyz);
    r7.x = rsqrt(r7.x);
    r9.xyz = r9.xyz * r7.xxx;
    r7.x = saturate(dot(r9.xyz, r5.xyz));
    r7.x = 1 + -r7.x;
    r7.z = r7.x * r7.x;
    r7.z = r7.z * r7.z;
    r7.x = r7.x * r7.z;
    r7.x = specularFresnel * r7.x + r7.w;
    r7.z = saturate(dot(r9.xyz, r4.xyz));
    r7.z = log2(r7.z);
    r7.z = r8.y * r7.z;
    r7.z = exp2(r7.z);
    r7.x = r7.x * r7.z;
    r6.z = r7.x * r6.z;
    r6.y = r6.z * r6.y;
    r6.y = r6.y * r8.x;
    r9.xyz = gLightColourAndCapsuleExtent[0].xyz * r6.yyy;
  } else {
    r10.xyz = float3(0,0,0);
    r9.xyz = float3(0,0,0);
  }
  r6.y = cmp(0 < gNumForwardLights);
  if (r6.y != 0) {
    r6.z = cmp(1 >= gNumForwardLights);
    r7.x = (int)r6.x | (int)r6.y;
    r6.z = r6.z ? r7.x : r6.x;
    if (r6.z == 0) {
      r7.x = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[1].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[1].xyz + r0.xyz;
      r7.z = dot(r12.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r7.z = saturate(r7.z / r8.w);
      r7.z = gLightColourAndCapsuleExtent[1].w * r7.z;
      r12.xyz = gLightDirectionAndFalloffExponent[1].xyz * r7.zzz + gLightPositionAndInvDistSqr[1].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r7.xxx ? r11.xyz : r12.xyz;
      r7.x = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r7.z = dot(r11.xyz, r11.xyz);
      r7.z = rsqrt(r7.z);
      r11.xyz = r11.xyz * r7.zzz;
      r7.x = saturate(-r7.x * gLightPositionAndInvDistSqr[1].w + 1);
      r7.z = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r7.z = r7.z * r7.x + gLightDirectionAndFalloffExponent[1].w;
      r7.x = r7.x / r7.z;
      r7.z = dot(r11.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r7.z = saturate(r7.z * gLightConeScale[1] + gLightConeOffset[1]);
      r8.w = dot(r11.xyz, r4.xyz);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = v1.w * r9.w + abs(r8.w);
      r7.z = r8.w * r7.z;
      r8.w = r7.z * r7.x;
      r10.xyz = r8.www * gLightColourAndCapsuleExtent[1].xyz + r10.xyz;
      r11.xyz = r2.xyz * r3.www + r11.xyz;
      r8.w = dot(r11.xyz, r11.xyz);
      r8.w = rsqrt(r8.w);
      r11.xyz = r11.xyz * r8.www;
      r8.w = saturate(dot(r11.xyz, r5.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = specularFresnel * r8.w + r7.w;
      r9.w = saturate(dot(r11.xyz, r4.xyz));
      r9.w = log2(r9.w);
      r9.w = r9.w * r8.y;
      r9.w = exp2(r9.w);
      r8.w = r9.w * r8.w;
      r7.z = r8.w * r7.z;
      r7.x = r7.z * r7.x;
      r7.x = r7.x * r8.x;
      r9.xyz = r7.xxx * gLightColourAndCapsuleExtent[1].xyz + r9.xyz;
    }
  } else {
    r6.z = -1;
  }
  if (r6.z == 0) {
    r7.x = cmp(2 >= gNumForwardLights);
    r6.z = (int)r6.z | (int)r7.x;
    if (r6.z == 0) {
      r7.x = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[2].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[2].xyz + r0.xyz;
      r7.z = dot(r12.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r7.z = saturate(r7.z / r8.w);
      r7.z = gLightColourAndCapsuleExtent[2].w * r7.z;
      r12.xyz = gLightDirectionAndFalloffExponent[2].xyz * r7.zzz + gLightPositionAndInvDistSqr[2].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r7.xxx ? r11.xyz : r12.xyz;
      r7.x = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r7.z = dot(r11.xyz, r11.xyz);
      r7.z = rsqrt(r7.z);
      r11.xyz = r11.xyz * r7.zzz;
      r7.x = saturate(-r7.x * gLightPositionAndInvDistSqr[2].w + 1);
      r7.z = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r7.z = r7.z * r7.x + gLightDirectionAndFalloffExponent[2].w;
      r7.x = r7.x / r7.z;
      r7.z = dot(r11.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r7.z = saturate(r7.z * gLightConeScale[2] + gLightConeOffset[2]);
      r8.w = dot(r11.xyz, r4.xyz);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = v1.w * r9.w + abs(r8.w);
      r7.z = r8.w * r7.z;
      r8.w = r7.z * r7.x;
      r10.xyz = r8.www * gLightColourAndCapsuleExtent[2].xyz + r10.xyz;
      r11.xyz = r2.xyz * r3.www + r11.xyz;
      r8.w = dot(r11.xyz, r11.xyz);
      r8.w = rsqrt(r8.w);
      r11.xyz = r11.xyz * r8.www;
      r8.w = saturate(dot(r11.xyz, r5.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = specularFresnel * r8.w + r7.w;
      r9.w = saturate(dot(r11.xyz, r4.xyz));
      r9.w = log2(r9.w);
      r9.w = r9.w * r8.y;
      r9.w = exp2(r9.w);
      r8.w = r9.w * r8.w;
      r7.z = r8.w * r7.z;
      r7.x = r7.z * r7.x;
      r7.x = r7.x * r8.x;
      r9.xyz = r7.xxx * gLightColourAndCapsuleExtent[2].xyz + r9.xyz;
    }
  } else {
    r6.z = -1;
  }
  if (r6.z == 0) {
    r7.x = cmp(3 >= gNumForwardLights);
    r6.z = (int)r6.z | (int)r7.x;
    if (r6.z == 0) {
      r6.z = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[3].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[3].xyz + r0.xyz;
      r7.x = dot(r12.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r7.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r7.x = saturate(r7.x / r7.z);
      r7.x = gLightColourAndCapsuleExtent[3].w * r7.x;
      r12.xyz = gLightDirectionAndFalloffExponent[3].xyz * r7.xxx + gLightPositionAndInvDistSqr[3].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r6.zzz ? r11.xyz : r12.xyz;
      r6.z = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r7.x = dot(r11.xyz, r11.xyz);
      r7.x = rsqrt(r7.x);
      r11.xyz = r11.xyz * r7.xxx;
      r6.z = saturate(-r6.z * gLightPositionAndInvDistSqr[3].w + 1);
      r7.x = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r7.x = r7.x * r6.z + gLightDirectionAndFalloffExponent[3].w;
      r6.z = r6.z / r7.x;
      r7.x = dot(r11.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r7.x = saturate(r7.x * gLightConeScale[3] + gLightConeOffset[3]);
      r7.z = dot(r11.xyz, r4.xyz);
      r8.w = saturate(r7.z);
      r8.w = r8.w + -abs(r7.z);
      r7.z = v1.w * r8.w + abs(r7.z);
      r7.x = r7.z * r7.x;
      r7.z = r7.x * r6.z;
      r10.xyz = r7.zzz * gLightColourAndCapsuleExtent[3].xyz + r10.xyz;
      r11.xyz = r2.xyz * r3.www + r11.xyz;
      r7.z = dot(r11.xyz, r11.xyz);
      r7.z = rsqrt(r7.z);
      r11.xyz = r11.xyz * r7.zzz;
      r7.z = saturate(dot(r11.xyz, r5.xyz));
      r7.z = 1 + -r7.z;
      r8.w = r7.z * r7.z;
      r8.w = r8.w * r8.w;
      r7.z = r8.w * r7.z;
      r7.z = specularFresnel * r7.z + r7.w;
      r8.w = saturate(dot(r11.xyz, r4.xyz));
      r8.w = log2(r8.w);
      r8.w = r8.y * r8.w;
      r8.w = exp2(r8.w);
      r7.z = r8.w * r7.z;
      r7.x = r7.z * r7.x;
      r6.z = r7.x * r6.z;
      r6.z = r6.z * r8.x;
      r9.xyz = r6.zzz * gLightColourAndCapsuleExtent[3].xyz + r9.xyz;
    }
  }
  r6.z = r7.y * r7.y;
  r4.w = r4.w * r4.w;
  o5.w = 1 + -r7.y;
  o7.xyz = r6.zzz * r10.xyz;
  o8.xyz = r4.www * r9.xyz;
  if (r6.x == 0) {
    r7.x = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r9.xyz = gLightPositionAndInvDistSqr[0].xyz + -r0.xyz;
    r10.xyz = -gLightPositionAndInvDistSqr[0].xyz + r0.xyz;
    r7.z = dot(r10.xyz, gLightDirectionAndFalloffExponent[0].xyz);
    r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r7.z = saturate(r7.z / r8.w);
    r7.z = gLightColourAndCapsuleExtent[0].w * r7.z;
    r10.xyz = gLightDirectionAndFalloffExponent[0].xyz * r7.zzz + gLightPositionAndInvDistSqr[0].xyz;
    r10.xyz = r10.xyz + -r0.xyz;
    r9.xyz = r7.xxx ? r9.xyz : r10.xyz;
    r7.x = dot(r9.xyz, r9.xyz);
    r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
    r7.z = dot(r9.xyz, r9.xyz);
    r7.z = rsqrt(r7.z);
    r9.xyz = r9.xyz * r7.zzz;
    r7.x = saturate(-r7.x * gLightPositionAndInvDistSqr[0].w + 1);
    r7.z = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r7.z = r7.z * r7.x + gLightDirectionAndFalloffExponent[0].w;
    r7.x = r7.x / r7.z;
    r7.z = dot(r9.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
    r7.z = saturate(r7.z * gLightConeScale[0] + gLightConeOffset[0]);
    r8.w = dot(r9.xyz, -r4.xyz);
    r9.w = saturate(r8.w);
    r9.w = r9.w + -abs(r8.w);
    r8.w = v1.w * r9.w + abs(r8.w);
    r7.z = r8.w * r7.z;
    r8.w = r7.z * r7.x;
    r10.xyz = gLightColourAndCapsuleExtent[0].xyz * r8.www;
    r9.xyz = r2.xyz * r3.www + r9.xyz;
    r8.w = dot(r9.xyz, r9.xyz);
    r8.w = rsqrt(r8.w);
    r9.xyz = r9.xyz * r8.www;
    r8.w = saturate(dot(r9.xyz, r5.xyz));
    r8.w = 1 + -r8.w;
    r9.w = r8.w * r8.w;
    r9.w = r9.w * r9.w;
    r8.w = r9.w * r8.w;
    r8.w = specularFresnel * r8.w + r7.w;
    r9.x = saturate(dot(r9.xyz, -r4.xyz));
    r9.x = log2(r9.x);
    r9.x = r9.x * r8.y;
    r9.x = exp2(r9.x);
    r8.w = r9.x * r8.w;
    r7.z = r8.w * r7.z;
    r7.x = r7.z * r7.x;
    r7.x = r7.x * r8.x;
    r9.xyz = gLightColourAndCapsuleExtent[0].xyz * r7.xxx;
  } else {
    r10.xyz = float3(0,0,0);
    r9.xyz = float3(0,0,0);
  }
  if (r6.y != 0) {
    r7.x = cmp(1 >= gNumForwardLights);
    r6.y = (int)r6.x | (int)r6.y;
    r6.x = r7.x ? r6.y : r6.x;
    if (r6.x == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[1].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[1].xyz + r0.xyz;
      r7.x = dot(r12.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r7.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r7.x = saturate(r7.x / r7.z);
      r7.x = gLightColourAndCapsuleExtent[1].w * r7.x;
      r12.xyz = gLightDirectionAndFalloffExponent[1].xyz * r7.xxx + gLightPositionAndInvDistSqr[1].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r6.yyy ? r11.xyz : r12.xyz;
      r6.y = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r7.x = dot(r11.xyz, r11.xyz);
      r7.x = rsqrt(r7.x);
      r11.xyz = r11.xyz * r7.xxx;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[1].w + 1);
      r7.x = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r7.x = r7.x * r6.y + gLightDirectionAndFalloffExponent[1].w;
      r6.y = r6.y / r7.x;
      r7.x = dot(r11.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r7.x = saturate(r7.x * gLightConeScale[1] + gLightConeOffset[1]);
      r7.z = dot(r11.xyz, -r4.xyz);
      r8.w = saturate(r7.z);
      r8.w = r8.w + -abs(r7.z);
      r7.z = v1.w * r8.w + abs(r7.z);
      r7.x = r7.z * r7.x;
      r7.z = r7.x * r6.y;
      r10.xyz = r7.zzz * gLightColourAndCapsuleExtent[1].xyz + r10.xyz;
      r11.xyz = r2.xyz * r3.www + r11.xyz;
      r7.z = dot(r11.xyz, r11.xyz);
      r7.z = rsqrt(r7.z);
      r11.xyz = r11.xyz * r7.zzz;
      r7.z = saturate(dot(r11.xyz, r5.xyz));
      r7.z = 1 + -r7.z;
      r8.w = r7.z * r7.z;
      r8.w = r8.w * r8.w;
      r7.z = r8.w * r7.z;
      r7.z = specularFresnel * r7.z + r7.w;
      r8.w = saturate(dot(r11.xyz, -r4.xyz));
      r8.w = log2(r8.w);
      r8.w = r8.y * r8.w;
      r8.w = exp2(r8.w);
      r7.z = r8.w * r7.z;
      r7.x = r7.z * r7.x;
      r6.y = r7.x * r6.y;
      r6.y = r6.y * r8.x;
      r9.xyz = r6.yyy * gLightColourAndCapsuleExtent[1].xyz + r9.xyz;
    }
  } else {
    r6.x = -1;
  }
  if (r6.x == 0) {
    r6.y = cmp(2 >= gNumForwardLights);
    r6.x = (int)r6.x | (int)r6.y;
    if (r6.x == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[2].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[2].xyz + r0.xyz;
      r7.x = dot(r12.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r7.z = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r7.x = saturate(r7.x / r7.z);
      r7.x = gLightColourAndCapsuleExtent[2].w * r7.x;
      r12.xyz = gLightDirectionAndFalloffExponent[2].xyz * r7.xxx + gLightPositionAndInvDistSqr[2].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r6.yyy ? r11.xyz : r12.xyz;
      r6.y = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r7.x = dot(r11.xyz, r11.xyz);
      r7.x = rsqrt(r7.x);
      r11.xyz = r11.xyz * r7.xxx;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[2].w + 1);
      r7.x = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r7.x = r7.x * r6.y + gLightDirectionAndFalloffExponent[2].w;
      r6.y = r6.y / r7.x;
      r7.x = dot(r11.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r7.x = saturate(r7.x * gLightConeScale[2] + gLightConeOffset[2]);
      r7.z = dot(r11.xyz, -r4.xyz);
      r8.w = saturate(r7.z);
      r8.w = r8.w + -abs(r7.z);
      r7.z = v1.w * r8.w + abs(r7.z);
      r7.x = r7.z * r7.x;
      r7.z = r7.x * r6.y;
      r10.xyz = r7.zzz * gLightColourAndCapsuleExtent[2].xyz + r10.xyz;
      r11.xyz = r2.xyz * r3.www + r11.xyz;
      r7.z = dot(r11.xyz, r11.xyz);
      r7.z = rsqrt(r7.z);
      r11.xyz = r11.xyz * r7.zzz;
      r7.z = saturate(dot(r11.xyz, r5.xyz));
      r7.z = 1 + -r7.z;
      r8.w = r7.z * r7.z;
      r8.w = r8.w * r8.w;
      r7.z = r8.w * r7.z;
      r7.z = specularFresnel * r7.z + r7.w;
      r8.w = saturate(dot(r11.xyz, -r4.xyz));
      r8.w = log2(r8.w);
      r8.w = r8.y * r8.w;
      r8.w = exp2(r8.w);
      r7.z = r8.w * r7.z;
      r7.x = r7.z * r7.x;
      r6.y = r7.x * r6.y;
      r6.y = r6.y * r8.x;
      r9.xyz = r6.yyy * gLightColourAndCapsuleExtent[2].xyz + r9.xyz;
    }
  } else {
    r6.x = -1;
  }
  if (r6.x == 0) {
    r6.y = cmp(3 >= gNumForwardLights);
    r6.x = (int)r6.x | (int)r6.y;
    if (r6.x == 0) {
      r6.x = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r11.xyz = gLightPositionAndInvDistSqr[3].xyz + -r0.xyz;
      r12.xyz = -gLightPositionAndInvDistSqr[3].xyz + r0.xyz;
      r6.y = dot(r12.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r7.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r6.y = saturate(r6.y / r7.x);
      r6.y = gLightColourAndCapsuleExtent[3].w * r6.y;
      r12.xyz = gLightDirectionAndFalloffExponent[3].xyz * r6.yyy + gLightPositionAndInvDistSqr[3].xyz;
      r12.xyz = r12.xyz + -r0.xyz;
      r11.xyz = r6.xxx ? r11.xyz : r12.xyz;
      r6.x = dot(r11.xyz, r11.xyz);
      r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
      r6.y = dot(r11.xyz, r11.xyz);
      r6.y = rsqrt(r6.y);
      r11.xyz = r11.xyz * r6.yyy;
      r6.x = saturate(-r6.x * gLightPositionAndInvDistSqr[3].w + 1);
      r6.y = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r6.y = r6.y * r6.x + gLightDirectionAndFalloffExponent[3].w;
      r6.x = r6.x / r6.y;
      r6.y = dot(r11.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r6.y = saturate(r6.y * gLightConeScale[3] + gLightConeOffset[3]);
      r7.x = dot(r11.xyz, -r4.xyz);
      r7.z = saturate(r7.x);
      r7.z = r7.z + -abs(r7.x);
      r7.x = v1.w * r7.z + abs(r7.x);
      r6.y = r7.x * r6.y;
      r7.x = r6.y * r6.x;
      r10.xyz = r7.xxx * gLightColourAndCapsuleExtent[3].xyz + r10.xyz;
      r2.xyz = r2.xyz * r3.www + r11.xyz;
      r3.w = dot(r2.xyz, r2.xyz);
      r3.w = rsqrt(r3.w);
      r2.xyz = r3.www * r2.xyz;
      r3.w = saturate(dot(r2.xyz, r5.xyz));
      r3.w = 1 + -r3.w;
      r5.x = r3.w * r3.w;
      r5.x = r5.x * r5.x;
      r3.w = r5.x * r3.w;
      r3.w = specularFresnel * r3.w + r7.w;
      r2.x = saturate(dot(r2.xyz, -r4.xyz));
      r2.x = log2(r2.x);
      r2.x = r8.y * r2.x;
      r2.x = exp2(r2.x);
      r2.x = r3.w * r2.x;
      r2.x = r2.x * r6.y;
      r2.x = r2.x * r6.x;
      r2.x = r2.x * r8.x;
      r9.xyz = r2.xxx * gLightColourAndCapsuleExtent[3].xyz + r9.xyz;
    }
  }
  o9.xyz = r10.xyz * r6.zzz;
  o10.xyz = r9.xyz * r4.www;
  r2.x = r3.z * r2.w + gLightNaturalAmbient0.w;
  r2.x = gLightNaturalAmbient1.w * r2.x;
  r2.x = max(0, r2.x);
  r2.yzw = gLightArtificialExtAmbient0.xyz * r2.xxx + gLightArtificialExtAmbient1.xyz;
  r3.w = 1 + -globalScalars2.z;
  r5.xyz = gLightArtificialIntAmbient0.xyz * r2.xxx + gLightArtificialIntAmbient1.xyz;
  r5.xyz = globalScalars2.zzz * r5.xyz;
  r2.yzw = r2.yzw * r3.www + r5.xyz;
  r2.yzw = r2.yzw * r0.www;
  r5.xyz = gLightNaturalAmbient0.xyz * r2.xxx + gLightNaturalAmbient1.xyz;
  r6.x = gLightArtificialIntAmbient1.w;
  r6.y = gLightArtificialExtAmbient0.w;
  r6.z = gLightArtificialExtAmbient1.w;
  r2.x = saturate(dot(r6.xyz, r4.xyz));
  r4.xyz = gDirectionalAmbientColour.xyz * r2.xxx + r5.xyz;
  r2.xyz = r4.xyz * r5.www + r2.yzw;
  o11.xyz = r2.xyz * r7.yyy;
  o13.x = dot(r1.xyzw, ClipPlanes.xyzw);
  o0.xyzw = float4(0,0,0,0);
  o1.xyzw = float4(0,0,0,0);
  o2.xy = v2.xy;
  o2.zw = float2(0,0);
  o6.w = r6.w;
  o7.w = r5.w;
  o8.w = r0.w;
  o9.w = v1.w;
  o10.w = r8.z;
  o12.xyzw = r1.xyzw;
  o13.yzw = float3(0,0,0);
  o3.xyz = r0.xyz;
  o4.xyz = r3.xyz;
  return;
}
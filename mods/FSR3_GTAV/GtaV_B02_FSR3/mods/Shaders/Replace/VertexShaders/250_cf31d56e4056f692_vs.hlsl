// ---- FNV Hash cf31d56e4056f692

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:14:14 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
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

cbuffer ptxgpu_common_locals : register(b9)
{
  float4 gParticleTextureSize : packoffset(c0);
}

cbuffer ptxgpu_render_locals : register(b8)
{
  float gLightIntensityMult : packoffset(c0);
  float4 gTextureRowsColsStartEnd : packoffset(c1);
  float4 gTextureAnimRateScaleOverLifeStart2End2 : packoffset(c2);
  float4 gSizeMinRange : packoffset(c3);
  float4 gColour : packoffset(c4);
  float2 gFadeInOut : packoffset(c5);
  float2 gRotSpeedMinRange : packoffset(c5.z);
  float3 gDirectionalZOffsetMinRange : packoffset(c6);
  float2 gFadeNearFar : packoffset(c7);
  float3 gFadeZBaseLoHi : packoffset(c8);
  float3 gDirectionalVelocityAdd : packoffset(c9);
  float gEdgeSoftness : packoffset(c9.w);
  float gMaxLife : packoffset(c10);
  float3 gRefParticlePos : packoffset(c10.y);
  float gParticleColorPercentage : packoffset(c11);
  float gBackgroundDistortionVisibilityPercentage : packoffset(c11.y);
  float gBackgroundDistortionAlphaBooster : packoffset(c11.z);
  float gBackgroundDistortionAmount : packoffset(c11.w);
  float gDirectionalLightShadowAmount : packoffset(c12);
  float gLocalLightsMultiplier : packoffset(c12.y);
  float4 gCamAngleLimits : packoffset(c13);
}

SamplerState ParticlePosTexSampler_s : register(s5);
SamplerState ParticleVelTexSampler_s : register(s6);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> ParticlePosTexSampler : register(t5);
Texture2D<float4> ParticleVelTexSampler : register(t6);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float2 v0 : TEXCOORD0,
  uint v1 : SV_InstanceID0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD4,
  out float4 o4 : TEXCOORD5,
  out float2 o5 : TEXCOORD6,
  out float4 o6 : SV_Position0,
  out float4 o7 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{
  const float4 icb[] = { { 0.020275, -0.786766, 0, 0},
                              { -0.701583, -0.474762, 0, 0},
                              { 0.544736, -0.062819, 0, 0},
                              { -0.123365, -0.129010, 0, 0},
                              { 0.720214, -0.599874, 0, 0},
                              { 0.588770, 0.806246, 0, 0},
                              { -0.558841, 0.331680, 0, 0},
                              { -0.331183, 0.887912, 0, 0},
                              { 0.050356, 0.486510, 0, 0},
                              { 0.924403, 0.360593, 0, 0} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input_sgv v1.x, instance_id
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.x = (uint)v1.x;
  r0.x = r0.x / gParticleTextureSize.x;
  r0.y = cmp(r0.x >= -r0.x);
  r0.z = frac(abs(r0.x));
  r0.y = r0.y ? r0.z : -r0.z;
  r1.x = gParticleTextureSize.x * r0.y;
  r1.y = floor(r0.x);
  r0.xy = gParticleTextureSize.zw * r1.xy;
  r1.xyzw = ParticlePosTexSampler.SampleLevel(ParticlePosTexSampler_s, r0.xy, 0).xyzw;
  r0.xyzw = ParticleVelTexSampler.SampleLevel(ParticleVelTexSampler_s, r0.xy, 0).xyzw;
  r2.xyz = gRefParticlePos.xyz + r1.xyz;
  r1.x = frac(r0.w);
  r0.w = -r1.x + r0.w;
  r0.w = gMaxLife * r0.w;
  r1.y = 0.00392156886 * r0.w;
  r3.xy = float2(10,1000) * r1.xx;
  r3.xy = frac(r3.xy);
  r3.xz = gSizeMinRange.zw * r3.xx + gSizeMinRange.xy;
  r1.z = gDirectionalZOffsetMinRange.z * r3.y + gDirectionalZOffsetMinRange.y;
  r2.w = r3.z * r1.z + r2.z;
  r3.yw = float2(-0.5,-0.5) + v0.xy;
  r1.z = cmp(0 < gDirectionalZOffsetMinRange.x);
  if (r1.z != 0) {
    r0.xyz = gDirectionalVelocityAdd.xyz + r0.xyz;
    r4.xyz = gViewInverse._m31_m32_m30 + -r2.ywx;
    r1.z = dot(r0.xyz, r0.xyz);
    r1.z = rsqrt(r1.z);
    r0.xyz = r1.zzz * r0.xyz;
    r5.xyz = r0.zxy * r4.xyz;
    r4.xyz = r0.yzx * r4.yzx + -r5.xyz;
    r1.z = dot(r4.xyz, r4.xyz);
    r1.z = rsqrt(r1.z);
    r4.xyz = r4.xyz * r1.zzz;
    r1.z = r3.y * r3.x;
    r4.w = 0.699999988 + -v0.y;
    r4.w = r4.w * r3.z;
    r5.xyz = r4.www * -r0.xyz;
    r5.xyz = r1.zzz * r4.xyz + r5.xyz;
  } else {
    r1.z = 100 * r1.x;
    r1.z = frac(r1.z);
    r1.z = gRotSpeedMinRange.y * r1.z + gRotSpeedMinRange.x;
    r1.z = r1.z * abs(r1.w);
    sincos(r1.z, r6.x, r7.x);
    r6.xyzw = gViewInverse._m20_m21_m22_m20 * r6.xxxx;
    r7.yzw = r6.zwy + r6.zwy;
    r8.xyz = r7.zwy * r6.xyz;
    r9.xyz = r7.xxx * r7.yzw;
    r8.xyz = r8.yxx + r8.zzy;
    r10.x = r6.w * r7.w + -r9.x;
    r11.x = r6.w * r7.w + r9.x;
    r11.yz = r6.yz * r7.yz + -r9.yz;
    r10.yz = r6.zy * r7.zy + r9.zy;
    r6.xyz = float3(1,1,1) + -r8.xyz;
    r7.xyz = r2.xyw;
    r7.w = r1.w;
    r7.xyzw = gViewInverse._m30_m31_m32_m33 + -r7.xyzw;
    r1.z = dot(r7.xyzw, r7.xyzw);
    r1.z = rsqrt(r1.z);
    r7.xyz = r7.yzx * r1.zzz;
    r1.z = cmp(r7.y < 0.999994993);
    r8.xyz = float3(0,1,0) * r7.zxy;
    r8.xyz = r7.xyz * float3(0,0,1) + -r8.xyz;
    r4.w = dot(r8.yz, r8.yz);
    r4.w = rsqrt(r4.w);
    r8.xyz = r8.xyz * r4.www;
    r9.xyz = r8.xyz * r7.xyz;
    r7.xyz = r8.zxy * r7.yzx + -r9.xyz;
    r4.w = dot(r7.xyz, r7.xyz);
    r4.w = rsqrt(r4.w);
    r7.xyz = r7.xyz * r4.www;
    r8.xy = r1.zz ? r8.yz : float2(1,0);
    r7.xyz = r1.zzz ? r7.xyz : float3(0,1,0);
    r10.w = r6.x;
    r0.x = dot(r7.yzx, r10.xyw);
    r11.w = r6.y;
    r0.y = dot(r7.xzy, r11.xyw);
    r6.x = r11.z;
    r6.y = r10.z;
    r0.z = dot(r7.xyz, r6.xyz);
    r4.x = dot(r8.yx, r10.xw);
    r4.y = dot(r8.xy, r11.xw);
    r4.z = dot(r8.xy, r6.xy);
    r3.xy = r3.yw * r3.xz;
    r3.yzw = r3.yyy * r0.xyz;
    r5.xyz = r3.xxx * r4.xyz + r3.yzw;
  }
  r3.xyz = r5.xyz + r2.xyw;
  pos.xyzw = float4(r3.xyz, 1);
  r5.xyzw = gWorldViewProj._m10_m11_m12_m13 * r3.yyyy;
  r5.xyzw = r3.xxxx * gWorldViewProj._m00_m01_m02_m03 + r5.xyzw;
  r5.xyzw = r3.zzzz * gWorldViewProj._m20_m21_m22_m23 + r5.xyzw;
  r5.xyzw = gWorldViewProj._m30_m31_m32_m33 + r5.xyzw;
  r0.w = r0.w * 0.00392156886 + -abs(r1.w);
  r1.z = gTextureAnimRateScaleOverLifeStart2End2.x * r0.w;
  r1.y = r0.w / r1.y;
  r1.y = r1.y * gTextureAnimRateScaleOverLifeStart2End2.x + -r1.z;
  r1.y = gTextureAnimRateScaleOverLifeStart2End2.y * r1.y + r1.z;
  r1.y = frac(r1.y);
  r1.z = cmp(0 >= gTextureAnimRateScaleOverLifeStart2End2.x);
  r1.z = r1.z ? 1.000000 : 0;
  r1.x = r1.x + -r1.y;
  r1.x = r1.x * r1.z + r1.y;
  r1.x = 0.999000013 * r1.x;
  r1.y = 1 + gTextureRowsColsStartEnd.w;
  r1.y = -gTextureRowsColsStartEnd.z + r1.y;
  r1.x = r1.x * r1.y + gTextureRowsColsStartEnd.z;
  r1.x = floor(r1.x);
  r1.x = r1.x / gTextureRowsColsStartEnd.y;
  r1.y = cmp(r1.x >= -r1.x);
  r1.z = frac(abs(r1.x));
  r1.y = r1.y ? r1.z : -r1.z;
  r6.x = gTextureRowsColsStartEnd.y * r1.y;
  r6.y = floor(r1.x);
  r1.xy = float2(1,1) / gTextureRowsColsStartEnd.yx;
  r6.xy = v0.xy + r6.xy;
  o1.xy = r6.xy * r1.xy;
  r1.xy = gViewInverse._m30_m31 + -r2.xy;
  r1.x = dot(r1.xy, r1.xy);
  r1.x = sqrt(r1.x);
  r1.y = gFadeNearFar.x * r1.x;
  r1.x = -r1.x * gFadeNearFar.y + 1;
  r1.z = r1.x * r1.x;
  r1.x = saturate(r1.z * r1.x);
  r1.x = gColour.w * r1.x;
  r1.z = r1.y * r1.y;
  r1.y = saturate(r1.z * r1.y);
  r1.x = r1.x * r1.y;
  r1.y = -gFadeZBaseLoHi.x + r2.z;
  r1.yz = saturate(abs(gFadeZBaseLoHi.yz) * r1.yy);
  r1.x = r1.x * r1.y;
  r1.y = 1 + -r1.z;
  r1.x = r1.x * r1.y;
  r0.w = saturate(gFadeInOut.x * r0.w);
  r1.y = saturate(gFadeInOut.y * abs(r1.w));
  r0.w = r1.y * r0.w;
  r0.w = r1.x * r0.w;
  r1.xyz = gViewInverse._m30_m31_m32 + -r2.xyz;
  r2.w = dot(r1.xyz, r1.xyz);
  r2.w = rsqrt(r2.w);
  r1.xyz = r2.www * r1.xyz;
  r2.w = cmp(0 >= gNumForwardLights);
  r3.w = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
  r6.xyz = gLightPositionAndInvDistSqr[0].xyz + -r2.xyz;
  r7.xyz = -gLightPositionAndInvDistSqr[0].xyz + r2.xyz;
  r4.w = dot(r7.xyz, gLightDirectionAndFalloffExponent[0].xyz);
  r6.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
  r4.w = saturate(r4.w / r6.w);
  r4.w = gLightColourAndCapsuleExtent[0].w * r4.w;
  r7.xyz = gLightDirectionAndFalloffExponent[0].xyz * r4.www + gLightPositionAndInvDistSqr[0].xyz;
  r7.xyz = r7.xyz + -r2.xyz;
  r6.xyz = r3.www ? r6.xyz : r7.xyz;
  r3.w = dot(r6.xyz, r6.xyz);
  r6.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r6.xyz;
  r4.w = dot(r6.xyz, r6.xyz);
  r4.w = rsqrt(r4.w);
  r6.xyz = r6.xyz * r4.www;
  r3.w = saturate(-r3.w * gLightPositionAndInvDistSqr[0].w + 1);
  r4.w = 1 + -gLightDirectionAndFalloffExponent[0].w;
  r4.w = r4.w * r3.w + gLightDirectionAndFalloffExponent[0].w;
  r3.w = r3.w / r4.w;
  r4.w = dot(r6.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
  r4.w = saturate(r4.w * gLightConeScale[0] + gLightConeOffset[0]);
  r6.x = dot(r6.xyz, r1.xyz);
  r6.y = saturate(r6.x);
  r6.y = r6.y + -abs(r6.x);
  r6.x = r0.w * r6.y + abs(r6.x);
  r4.w = r6.x * r4.w;
  r3.w = r4.w * r3.w;
  r6.xyz = gLightColourAndCapsuleExtent[0].xyz * r3.www;
  r6.xyz = r2.www ? float3(0,0,0) : r6.xyz;
  r3.w = cmp(0 < gNumForwardLights);
  if (r3.w != 0) {
    r3.w = cmp(1 >= gNumForwardLights);
    r2.w = (int)r2.w | (int)r3.w;
    r3.w = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[1].xyz + -r2.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[1].xyz + r2.xyz;
    r4.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[1].xyz);
    r6.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
    r4.w = saturate(r4.w / r6.w);
    r4.w = gLightColourAndCapsuleExtent[1].w * r4.w;
    r8.xyz = gLightDirectionAndFalloffExponent[1].xyz * r4.www + gLightPositionAndInvDistSqr[1].xyz;
    r8.xyz = r8.xyz + -r2.xyz;
    r7.xyz = r3.www ? r7.xyz : r8.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r4.w = dot(r7.xyz, r7.xyz);
    r4.w = rsqrt(r4.w);
    r7.xyz = r7.xyz * r4.www;
    r3.w = saturate(-r3.w * gLightPositionAndInvDistSqr[1].w + 1);
    r4.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
    r4.w = r4.w * r3.w + gLightDirectionAndFalloffExponent[1].w;
    r3.w = r3.w / r4.w;
    r4.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
    r4.w = saturate(r4.w * gLightConeScale[1] + gLightConeOffset[1]);
    r6.w = dot(r7.xyz, r1.xyz);
    r7.x = saturate(r6.w);
    r7.x = r7.x + -abs(r6.w);
    r6.w = r0.w * r7.x + abs(r6.w);
    r4.w = r6.w * r4.w;
    r3.w = r4.w * r3.w;
    r7.xyz = r3.www * gLightColourAndCapsuleExtent[1].xyz + r6.xyz;
    r6.xyz = r2.www ? r6.xyz : r7.xyz;
  } else {
    r2.w = -1;
  }
  if (r2.w == 0) {
    r3.w = cmp(2 >= gNumForwardLights);
    r2.w = (int)r2.w | (int)r3.w;
    r3.w = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[2].xyz + -r2.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[2].xyz + r2.xyz;
    r4.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[2].xyz);
    r6.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
    r4.w = saturate(r4.w / r6.w);
    r4.w = gLightColourAndCapsuleExtent[2].w * r4.w;
    r8.xyz = gLightDirectionAndFalloffExponent[2].xyz * r4.www + gLightPositionAndInvDistSqr[2].xyz;
    r8.xyz = r8.xyz + -r2.xyz;
    r7.xyz = r3.www ? r7.xyz : r8.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r4.w = dot(r7.xyz, r7.xyz);
    r4.w = rsqrt(r4.w);
    r7.xyz = r7.xyz * r4.www;
    r3.w = saturate(-r3.w * gLightPositionAndInvDistSqr[2].w + 1);
    r4.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
    r4.w = r4.w * r3.w + gLightDirectionAndFalloffExponent[2].w;
    r3.w = r3.w / r4.w;
    r4.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
    r4.w = saturate(r4.w * gLightConeScale[2] + gLightConeOffset[2]);
    r6.w = dot(r7.xyz, r1.xyz);
    r7.x = saturate(r6.w);
    r7.x = r7.x + -abs(r6.w);
    r6.w = r0.w * r7.x + abs(r6.w);
    r4.w = r6.w * r4.w;
    r3.w = r4.w * r3.w;
    r7.xyz = r3.www * gLightColourAndCapsuleExtent[2].xyz + r6.xyz;
    r6.xyz = r2.www ? r6.xyz : r7.xyz;
  } else {
    r2.w = -1;
  }
  if (r2.w == 0) {
    r3.w = cmp(3 >= gNumForwardLights);
    r2.w = (int)r2.w | (int)r3.w;
    r3.w = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[3].xyz + -r2.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[3].xyz + r2.xyz;
    r4.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[3].xyz);
    r6.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
    r4.w = saturate(r4.w / r6.w);
    r4.w = gLightColourAndCapsuleExtent[3].w * r4.w;
    r8.xyz = gLightDirectionAndFalloffExponent[3].xyz * r4.www + gLightPositionAndInvDistSqr[3].xyz;
    r8.xyz = r8.xyz + -r2.xyz;
    r7.xyz = r3.www ? r7.xyz : r8.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r4.w = dot(r7.xyz, r7.xyz);
    r4.w = rsqrt(r4.w);
    r7.xyz = r7.xyz * r4.www;
    r3.w = saturate(-r3.w * gLightPositionAndInvDistSqr[3].w + 1);
    r4.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
    r4.w = r4.w * r3.w + gLightDirectionAndFalloffExponent[3].w;
    r3.w = r3.w / r4.w;
    r4.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
    r4.w = saturate(r4.w * gLightConeScale[3] + gLightConeOffset[3]);
    r1.x = dot(r7.xyz, r1.xyz);
    r1.y = saturate(r1.x);
    r1.y = r1.y + -abs(r1.x);
    r1.x = r0.w * r1.y + abs(r1.x);
    r1.x = r1.x * r4.w;
    r1.x = r1.x * r3.w;
    r1.xyz = r1.xxx * gLightColourAndCapsuleExtent[3].xyz + r6.xyz;
    r6.xyz = r2.www ? r6.xyz : r1.xyz;
  }
  r1.xyz = gLightNaturalAmbient1.xyz + gLightNaturalAmbient0.xyz;
  r2.w = cmp(0 < gDirectionalLightShadowAmount);
  if (r2.w != 0) {
    r7.xyz = gWorld._m10_m11_m12 * r3.yyy;
    r3.xyw = r3.xxx * gWorld._m00_m01_m02 + r7.xyz;
    r3.xyz = r3.zzz * gWorld._m20_m21_m22 + r3.xyw;
    r3.xyz = gWorld._m30_m31_m32 + r3.xyz;
    r7.xyz = r3.xyz + r2.xyz;
    r2.xyz = -r3.xyz + r2.xyz;
    r2.x = dot(r2.xyz, r2.xyz);
    r2.x = sqrt(r2.x);
    r2.y = -gCSMResolution.z * 1.5 + 1;
    r2.xy = float2(0.5,0.5) * r2.xy;
    r2.zw = float2(0,0);
    while (true) {
      r3.x = cmp((int)r2.w >= 10);
      if (r3.x != 0) break;
      r3.xyz = icb[r2.w+0].yyy * r0.xyz;
      r3.xyz = r4.xyz * icb[r2.w+0].xxx + r3.xyz;
      r3.xyz = r3.xyz * r2.xxx;
      r3.xyz = r7.xyz * float3(0.5,0.5,0.5) + r3.xyz;
      r3.xyz = -gViewInverse._m30_m31_m32 + r3.xyz;
      r8.xyz = gCSMShaderVars_shared[1].xyz * r3.yyy;
      r3.xyw = r3.xxx * gCSMShaderVars_shared[0].xyz + r8.xyz;
      r3.xyz = r3.zzz * gCSMShaderVars_shared[2].xyz + r3.xyw;
      r8.xyz = r3.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
      x0[0].xyz = r8.xyz;
      r9.xyz = r3.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
      x0[1].xyz = r9.xyz;
      r10.xyz = r3.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
      x0[2].xyz = r10.xyz;
      r3.xyz = r3.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
      x0[3].xyz = r3.xyz;
      r3.x = max(abs(r10.x), abs(r10.y));
      r3.x = cmp(r3.x < r2.y);
      r3.x = r3.x ? 2 : 3;
      r3.y = max(abs(r9.x), abs(r9.y));
      r3.y = cmp(r3.y < r2.y);
      r3.x = r3.y ? 1 : r3.x;
      r3.y = max(abs(r8.x), abs(r8.y));
      r3.y = cmp(r3.y < r2.y);
      r3.x = r3.y ? 0 : r3.x;
      r3.yzw = x0[r3.x+0].xyz;
      r3.x = (int)r3.x;
      r3.x = 0.5 + r3.x;
      r3.x = 0.25 * r3.x;
      r8.x = 0.5 + r3.y;
      r8.y = r3.z * 0.25 + r3.x;
      r3.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r3.w).x;
      r2.z = r3.x + r2.z;
      r2.w = (int)r2.w + 1;
    }
    r0.x = r2.z * 0.100000001 + -1;
    r0.x = gDirectionalLightShadowAmount * r0.x + 1;
    r0.xyz = gDirectionalColour.xyz * r0.xxx;
  } else {
    r0.xyz = gDirectionalColour.xyz;
  }
  r0.xyz = r0.xyz + r1.xyz;
  r1.xyz = gLocalLightsMultiplier * r6.xyz;
  o4.xyz = r0.xyz * gLightIntensityMult + r1.xyz;
  r0.x = cmp(0.00100000005 >= r0.w);
  r0.y = cmp(r1.w < 0);
  r0.x = (int)r0.y | (int)r0.x;
  o7.xyzw = r0.xxxx ? float4(-1,-1,-1,-1) : float4(1,1,1,1);
  o1.zw = v0.xy;
  o3.xyz = gColour.xyz;
  o3.w = r0.w;
  o4.w = r5.w;
  o6.xyzw = r5.xyzw;
  r0.xy = v0.xy;
  r0.z = 0;
  o0.xyz = r0.xyz;
  o2.xyz = r0.xyz;
  o5.xy = float2(0,0);
  return;
}
// ---- FNV Hash c4d77eab8f948efa

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
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float bumpiness : packoffset(c0.w);
  float wetnessMultiplier : packoffset(c1);
  float useTessellation : packoffset(c1.y);
  float HardAlphaBlend : packoffset(c1.z);
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

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState BumpSampler_s : register(s2);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> BumpSampler : register(t2);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD4,
  float4 v5 : TEXCOORD5,
  float4 v6 : TEXCOORD6,
  float4 v7 : SV_Position0,
  float4 v8 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.xyzw = BumpSampler.Sample(BumpSampler_s, v1.xy).xyzw;
  r1.xy = r1.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r1.xy, r1.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r1.xy = r1.xy * r1.ww;
  r2.xyz = v5.xyz * r1.yyy;
  r1.xyw = r1.xxx * v4.xyz + r2.xyz;
  r1.xyz = r1.zzz * v2.xyz + r1.xyw;
  r1.w = dot(r1.xyz, r1.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r1.xyz * r1.www;
  r0.w = v0.w * r0.w;
  r1.xy = globalScalars.zy * v0.xy;
  r0.xyz = r0.xyz * r0.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -v6.xyz;
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = rsqrt(r2.w);
  r4.xyz = r3.xyz * r2.www;
  r5.xyz = r3.xyz * r2.www + -gDirectionalLight.xyz;
  r3.w = dot(r5.xyz, r5.xyz);
  r3.w = rsqrt(r3.w);
  r5.xyz = r5.xyz * r3.www;
  r3.w = saturate(specularIntensityMult);
  r1.xy = r1.xy * r1.xy;
  r4.w = -500 + specularFalloffMult;
  r4.w = max(0, r4.w);
  r5.w = specularFalloffMult + -r4.w;
  r4.w = 558 * r4.w;
  r4.w = r5.w * 3 + r4.w;
  r5.w = dot(r3.xyz, gViewInverse._m20_m21_m22);
  r6.xyz = -gViewInverse._m30_m31_m32 + v6.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r6.yyy;
  r7.xyz = r6.xxx * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r7.xyz = r6.zzz * gCSMShaderVars_shared[2].xyz + r7.xyz;
  r8.xyz = r7.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r8.xyz;
  r9.xyz = r7.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r9.xyz;
  r10.xyz = r7.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r10.xyz;
  r7.xyz = r7.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r7.xyz;
  r11.yw = float2(-0.346096516,0.32848981) * gCSMResolution.zw;
  r6.w = -gCSMResolution.z * 1.5 + 1;
  r6.w = 0.5 * r6.w;
  r7.z = max(abs(r10.x), abs(r10.y));
  r7.z = cmp(r7.z < r6.w);
  r7.z = r7.z ? 2 : 3;
  r7.w = max(abs(r9.x), abs(r9.y));
  r7.w = cmp(r7.w < r6.w);
  r7.z = r7.w ? 1 : r7.z;
  r7.w = max(abs(r8.x), abs(r8.y));
  r6.w = cmp(r7.w < r6.w);
  r6.w = r6.w ? 0 : r7.z;
  r8.xyz = x0[r6.w+0].xyz;
  r6.w = (int)r6.w;
  r7.z = 0.5 + r6.w;
  r7.z = 0.25 * r7.z;
  r9.xyzw = cmp(float4(0,1,2,3) == r6.wwww);
  r9.xyzw = r9.xyzw ? float4(1,1,1,1) : 0;
  r6.w = dot(r9.xyzw, gCSMDepthBias.xyzw);
  r7.w = dot(r9.xyzw, gCSMDepthSlopeBias.xyzw);
  r9.x = 0.5 + r8.x;
  r9.y = r8.y * 0.25 + r7.z;
  r7.z = cmp(r6.w != 0.000000);
  r6.w = r8.z + -r6.w;
  r10.xyw = ddx(r9.xyy);
  r10.z = ddx(r6.w);
  r12.xyz = ddy(r9.yxy);
  r12.w = ddy(r6.w);
  r8.xy = r12.yw * r10.yw;
  r13.xy = r10.xz * r12.xz + -r8.xy;
  r8.x = 1 / r13.x;
  r8.y = r12.y * r10.z;
  r13.z = r10.x * r12.w + -r8.y;
  r8.xy = r13.yz * r8.xx;
  r8.xy = max(float2(0,0), r8.xy);
  r8.xy = min(float2(0.5,0.5), r8.xy);
  r6.w = -r7.w * r8.x + r6.w;
  r6.w = -r7.w * r8.y + r6.w;
  r11.z = r7.z ? r6.w : r8.z;
  r9.z = 0;
  r8.xyz = r11.ywz + r9.xyz;
  r11.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r10.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0311755072,0.179337755) * gCSMResolution.zw;
  r12.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.514749467,0.253502458) * gCSMResolution.zw;
  r13.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r14.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r15.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.545546651,0.0241285414) * gCSMResolution.zw;
  r16.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0289061088,-0.136784583) * gCSMResolution.zw;
  r17.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.47951147,-0.244832873) * gCSMResolution.zw;
  r18.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r19.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.339352578,-0.249327824) * gCSMResolution.zw;
  r20.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.07059765,0.208122596) * gCSMResolution.zw;
  r21.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.29403818,-0.0180776753) * gCSMResolution.zw;
  r22.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.747563064,-0.113974348) * gCSMResolution.zw;
  r23.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.94772172,-0.248763546) * gCSMResolution.zw;
  r24.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-1.34315288,-0.088584058) * gCSMResolution.zw;
  r9.xyz = r11.xyz + r9.xyz;
  r8.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r8.z).x;
  r8.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r8.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r12.xy, r12.z).x;
  r8.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r10.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r10.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r10.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r10.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r17.xy, r17.z).x;
  r11.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r11.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r19.xy, r19.z).x;
  r11.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r20.xy, r20.z).x;
  r11.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r21.xy, r21.z).x;
  r12.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r22.xy, r22.z).x;
  r12.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r23.xy, r23.z).x;
  r12.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r24.xy, r24.z).x;
  r12.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r8.xyzw = r10.xyzw + r8.xyzw;
  r8.xyzw = r8.xyzw + r11.xyzw;
  r8.xyzw = r8.xyzw + r12.xyzw;
  r6.w = dot(r8.xyzw, float4(1,1,1,1));
  r5.w = saturate(r5.w * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r7.x = max(abs(r7.x), abs(r7.y));
  r7.x = saturate(r7.x * 15 + -6.30000019);
  r5.w = 1 + -r5.w;
  r5.w = r5.w * r7.x;
  r5.w = r6.w * 0.0625 + r5.w;
  r5.w = r5.w * r5.w;
  r5.w = min(1, r5.w);
  r6.w = saturate(v6.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r6.w = sqrt(r6.w);
  r6.w = gCSMShaderVars_shared[3].z * r6.w;
  r5.w = r6.w * -r5.w + r5.w;
  r6.w = saturate(dot(r2.xyz, -gDirectionalLight.xyz));
  r7.x = saturate(dot(r4.xyz, r2.xyz));
  r7.y = saturate(dot(r5.xyz, -gDirectionalLight.xyz));
  r7.xy = float2(1,1) + -r7.xy;
  r7.zw = r7.xy * r7.xy;
  r7.zw = r7.zw * r7.zw;
  r7.xy = r7.zw * r7.xy;
  r7.z = 1 + -specularFresnel;
  r7.xy = specularFresnel * r7.xy + r7.zz;
  r8.xy = float2(2,9.99999994e-09) + r4.ww;
  r7.w = 0.125 * r8.x;
  r7.x = -r3.w * r7.x + 1;
  r5.x = dot(r2.xyz, r5.xyz);
  r5.x = saturate(9.99999994e-09 + r5.x);
  r5.x = log2(r5.x);
  r5.x = r8.y * r5.x;
  r5.x = exp2(r5.x);
  r5.x = r5.x * r7.y;
  r5.x = r5.x * r7.w;
  r5.x = r5.x * r3.w;
  r5.x = r5.x * r6.w;
  r5.y = r7.x * r6.w;
  r5.xyz = r0.xyz * r5.yyy + r5.xxx;
  r5.xyz = gDirectionalColour.xyz * r5.xyz;
  r6.w = cmp(0 >= gNumForwardLights);
  if (r6.w == 0) {
    r7.y = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r8.xzw = gLightPositionAndInvDistSqr[0].xyz + -v6.xyz;
    r9.xyz = -gLightPositionAndInvDistSqr[0].xyz + v6.xyz;
    r9.x = dot(r9.xyz, gLightDirectionAndFalloffExponent[0].xyz);
    r9.y = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r9.x = saturate(r9.x / r9.y);
    r9.x = gLightColourAndCapsuleExtent[0].w * r9.x;
    r9.xyz = gLightDirectionAndFalloffExponent[0].xyz * r9.xxx + gLightPositionAndInvDistSqr[0].xyz;
    r9.xyz = -v6.xyz + r9.xyz;
    r8.xzw = r7.yyy ? r8.xzw : r9.xyz;
    r7.y = dot(r8.xzw, r8.xzw);
    r8.xzw = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.xzw;
    r9.x = dot(r8.xzw, r8.xzw);
    r9.x = rsqrt(r9.x);
    r8.xzw = r9.xxx * r8.xzw;
    r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[0].w + 1);
    r9.x = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[0].w;
    r7.y = r7.y / r9.x;
    r9.x = dot(r8.xzw, -gLightDirectionAndFalloffExponent[0].xyz);
    r9.x = saturate(r9.x * gLightConeScale[0] + gLightConeOffset[0]);
    r9.y = saturate(dot(r8.xzw, r2.xyz));
    r9.x = r9.y * r9.x;
    r9.y = r9.x * r7.y;
    r9.yzw = gLightColourAndCapsuleExtent[0].xyz * r9.yyy;
    r9.yzw = r9.yzw * r0.xyz;
    r8.xzw = r3.xyz * r2.www + r8.xzw;
    r10.x = dot(r8.xzw, r8.xzw);
    r10.x = rsqrt(r10.x);
    r8.xzw = r10.xxx * r8.xzw;
    r10.x = saturate(dot(r8.xzw, r4.xyz));
    r10.x = 1 + -r10.x;
    r10.y = r10.x * r10.x;
    r10.y = r10.y * r10.y;
    r10.x = r10.x * r10.y;
    r10.x = specularFresnel * r10.x + r7.z;
    r8.x = saturate(dot(r8.xzw, r2.xyz));
    r8.x = log2(r8.x);
    r8.x = r8.y * r8.x;
    r8.x = exp2(r8.x);
    r8.x = r10.x * r8.x;
    r8.x = r8.x * r9.x;
    r7.y = r8.x * r7.y;
    r7.y = r7.y * r7.w;
    r8.xzw = gLightColourAndCapsuleExtent[0].xyz * r7.yyy;
  } else {
    r9.yzw = float3(0,0,0);
    r8.xzw = float3(0,0,0);
  }
  r7.y = cmp(0 < gNumForwardLights);
  if (r7.y != 0) {
    r9.x = cmp(1 >= gNumForwardLights);
    r7.y = (int)r6.w | (int)r7.y;
    r6.w = r9.x ? r7.y : r6.w;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[1].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[1].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[1].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[1].xyz * r9.xxx + gLightPositionAndInvDistSqr[1].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[1].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[1].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r9.x = saturate(r9.x * gLightConeScale[1] + gLightConeOffset[1]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[1].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[1].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(2 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[2].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[2].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[2].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[2].xyz * r9.xxx + gLightPositionAndInvDistSqr[2].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[2].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[2].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r9.x = saturate(r9.x * gLightConeScale[2] + gLightConeOffset[2]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[2].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[2].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(3 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[3].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[3].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[3].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[3].xyz * r9.xxx + gLightPositionAndInvDistSqr[3].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[3].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[3].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r9.x = saturate(r9.x * gLightConeScale[3] + gLightConeOffset[3]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[3].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[3].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(4 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[4].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[4].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[4].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[4].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[4].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[4].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[4].xyz * r9.xxx + gLightPositionAndInvDistSqr[4].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[4].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[4].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[4].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[4].xyz);
      r9.x = saturate(r9.x * gLightConeScale[4] + gLightConeOffset[4]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[4].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[4].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(5 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[5].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[5].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[5].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[5].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[5].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[5].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[5].xyz * r9.xxx + gLightPositionAndInvDistSqr[5].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[5].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[5].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[5].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[5].xyz);
      r9.x = saturate(r9.x * gLightConeScale[5] + gLightConeOffset[5]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[5].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[5].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(6 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r7.y = cmp(gLightColourAndCapsuleExtent[6].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[6].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[6].xyz + v6.xyz;
      r9.x = dot(r11.xyz, gLightDirectionAndFalloffExponent[6].xyz);
      r10.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[6].w;
      r9.x = saturate(r9.x / r10.w);
      r9.x = gLightColourAndCapsuleExtent[6].w * r9.x;
      r11.xyz = gLightDirectionAndFalloffExponent[6].xyz * r9.xxx + gLightPositionAndInvDistSqr[6].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r7.yyy ? r10.xyz : r11.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r9.x = dot(r10.xyz, r10.xyz);
      r9.x = rsqrt(r9.x);
      r10.xyz = r10.xyz * r9.xxx;
      r7.y = saturate(-r7.y * gLightPositionAndInvDistSqr[6].w + 1);
      r9.x = 1 + -gLightDirectionAndFalloffExponent[6].w;
      r9.x = r9.x * r7.y + gLightDirectionAndFalloffExponent[6].w;
      r7.y = r7.y / r9.x;
      r9.x = dot(r10.xyz, -gLightDirectionAndFalloffExponent[6].xyz);
      r9.x = saturate(r9.x * gLightConeScale[6] + gLightConeOffset[6]);
      r10.w = saturate(dot(r10.xyz, r2.xyz));
      r9.x = r10.w * r9.x;
      r10.w = r9.x * r7.y;
      r11.xyz = gLightColourAndCapsuleExtent[6].xyz * r10.www;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r10.xyz = r3.xyz * r2.www + r10.xyz;
      r10.w = dot(r10.xyz, r10.xyz);
      r10.w = rsqrt(r10.w);
      r10.xyz = r10.xyz * r10.www;
      r10.w = saturate(dot(r10.xyz, r4.xyz));
      r10.w = 1 + -r10.w;
      r11.x = r10.w * r10.w;
      r11.x = r11.x * r11.x;
      r10.w = r11.x * r10.w;
      r10.w = specularFresnel * r10.w + r7.z;
      r10.x = saturate(dot(r10.xyz, r2.xyz));
      r10.x = log2(r10.x);
      r10.x = r10.x * r8.y;
      r10.x = exp2(r10.x);
      r10.x = r10.w * r10.x;
      r9.x = r10.x * r9.x;
      r7.y = r9.x * r7.y;
      r7.y = r7.y * r7.w;
      r8.xzw = r7.yyy * gLightColourAndCapsuleExtent[6].xyz + r8.xzw;
    }
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.y = cmp(7 >= gNumForwardLights);
    r6.w = (int)r6.w | (int)r7.y;
    if (r6.w == 0) {
      r6.w = cmp(gLightColourAndCapsuleExtent[7].w == 0.000000);
      r10.xyz = gLightPositionAndInvDistSqr[7].xyz + -v6.xyz;
      r11.xyz = -gLightPositionAndInvDistSqr[7].xyz + v6.xyz;
      r7.y = dot(r11.xyz, gLightDirectionAndFalloffExponent[7].xyz);
      r9.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[7].w;
      r7.y = saturate(r7.y / r9.x);
      r7.y = gLightColourAndCapsuleExtent[7].w * r7.y;
      r11.xyz = gLightDirectionAndFalloffExponent[7].xyz * r7.yyy + gLightPositionAndInvDistSqr[7].xyz;
      r11.xyz = -v6.xyz + r11.xyz;
      r10.xyz = r6.www ? r10.xyz : r11.xyz;
      r6.w = dot(r10.xyz, r10.xyz);
      r10.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.xyz;
      r7.y = dot(r10.xyz, r10.xyz);
      r7.y = rsqrt(r7.y);
      r10.xyz = r10.xyz * r7.yyy;
      r6.w = saturate(-r6.w * gLightPositionAndInvDistSqr[7].w + 1);
      r7.y = 1 + -gLightDirectionAndFalloffExponent[7].w;
      r7.y = r7.y * r6.w + gLightDirectionAndFalloffExponent[7].w;
      r6.w = r6.w / r7.y;
      r7.y = dot(r10.xyz, -gLightDirectionAndFalloffExponent[7].xyz);
      r7.y = saturate(r7.y * gLightConeScale[7] + gLightConeOffset[7]);
      r9.x = saturate(dot(r10.xyz, r2.xyz));
      r7.y = r9.x * r7.y;
      r9.x = r7.y * r6.w;
      r11.xyz = gLightColourAndCapsuleExtent[7].xyz * r9.xxx;
      r9.yzw = r11.xyz * r0.xyz + r9.yzw;
      r3.xyz = r3.xyz * r2.www + r10.xyz;
      r2.w = dot(r3.xyz, r3.xyz);
      r2.w = rsqrt(r2.w);
      r3.xyz = r3.xyz * r2.www;
      r2.w = saturate(dot(r3.xyz, r4.xyz));
      r2.w = 1 + -r2.w;
      r9.x = r2.w * r2.w;
      r9.x = r9.x * r9.x;
      r2.w = r9.x * r2.w;
      r2.w = specularFresnel * r2.w + r7.z;
      r3.x = saturate(dot(r3.xyz, r2.xyz));
      r3.x = log2(r3.x);
      r3.x = r8.y * r3.x;
      r3.x = exp2(r3.x);
      r2.w = r3.x * r2.w;
      r2.w = r2.w * r7.y;
      r2.w = r2.w * r6.w;
      r2.w = r2.w * r7.w;
      r8.xzw = r2.www * gLightColourAndCapsuleExtent[7].xyz + r8.xzw;
    }
  }
  r2.w = r7.x * r7.x;
  r3.x = r3.w * r3.w;
  r3.xyz = r3.xxx * r8.xzw;
  r3.xyz = r2.www * r9.yzw + r3.xyz;
  r3.xyz = r5.xyz * r5.www + r3.xyz;
  r1.z = r1.z * r1.w + gLightNaturalAmbient0.w;
  r1.z = gLightNaturalAmbient1.w * r1.z;
  r1.z = max(0, r1.z);
  r5.xyz = gLightArtificialExtAmbient0.xyz * r1.zzz + gLightArtificialExtAmbient1.xyz;
  r1.w = 1 + -globalScalars2.z;
  r7.yzw = gLightArtificialIntAmbient0.xyz * r1.zzz + gLightArtificialIntAmbient1.xyz;
  r7.yzw = globalScalars2.zzz * r7.yzw;
  r5.xyz = r5.xyz * r1.www + r7.yzw;
  r5.xyz = r5.xyz * r1.yyy;
  r7.yzw = gLightNaturalAmbient0.xyz * r1.zzz + gLightNaturalAmbient1.xyz;
  r8.x = gLightArtificialIntAmbient1.w;
  r8.y = gLightArtificialExtAmbient0.w;
  r8.z = gLightArtificialExtAmbient1.w;
  r1.z = saturate(dot(r8.xyz, r2.xyz));
  r7.yzw = gDirectionalAmbientColour.xyz * r1.zzz + r7.yzw;
  r5.xyz = r7.yzw * r1.xxx + r5.xyz;
  r5.xyz = r5.xyz * r7.xxx;
  r0.xyz = r5.xyz * r0.xyz + r3.xyz;
  r1.z = 1 + -r7.x;
  r1.w = dot(-r4.xyz, r2.xyz);
  r1.w = r1.w + r1.w;
  r2.xyz = r2.xyz * -r1.www + -r4.xyz;
  r3.xy = saturate(float2(0.00066666666,0.00177619897) * r4.ww);
  r1.w = 1 + -r3.x;
  r2.w = -5 + gReflectionMipCount;
  r3.x = gReflectionMipCount * r1.w;
  r3.x = cmp(r3.x < r2.w);
  r3.z = r1.w * gReflectionMipCount + -5;
  r1.w = r1.w * r1.w;
  r1.w = r1.w * 5 + r2.w;
  r1.w = r3.x ? r3.z : r1.w;
  r2.xyw = float3(-0.25,0.5,0.25) * r2.xyx;
  r3.x = 1 + abs(r2.z);
  r2.xyw = r2.xyw / r3.xxx;
  r2.xyw = float3(0.75,0.5,0.25) + -r2.xyw;
  r2.z = cmp(0 < r2.z);
  r2.xy = r2.zz ? r2.xy : r2.wy;
  r2.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r2.xy, r1.w).xyzw;
  r1.x = max(r1.x, r1.y);
  r1.xyw = r2.xyz * r1.xxx;
  r2.xyz = r1.xyw * r3.yyy;
  r2.xyz = float3(0.681690097,0.681690097,0.681690097) * r2.xyz;
  r1.xyw = r1.xyw * float3(0.318309903,0.318309903,0.318309903) + r2.xyz;
  r0.xyz = r1.xyw * r1.zzz + r0.xyz;
  o0.w = globalScalars.x * r0.w;
  if (gUseFogRay != 0) {
    r0.w = dot(r6.xyz, r6.xyz);
    r1.x = sqrt(r0.w);
    r1.y = -globalFogParams[0].x + r1.x;
    r1.y = max(0, r1.y);
    r1.x = r1.y / r1.x;
    r1.x = r6.z * r1.x;
    r1.z = globalFogParams[2].z * r1.x;
    r1.x = cmp(0.00999999978 < abs(r1.x));
    r1.w = -1.44269502 * r1.z;
    r1.w = exp2(r1.w);
    r1.w = 1 + -r1.w;
    r1.z = r1.w / r1.z;
    r1.x = r1.x ? r1.z : 1;
    r1.z = globalFogParams[1].w * r1.y;
    r1.x = r1.z * r1.x;
    r1.x = min(1, r1.x);
    r1.x = 1.44269502 * r1.x;
    r1.x = exp2(r1.x);
    r1.x = min(1, r1.x);
    r1.x = 1 + -r1.x;
    r1.z = globalFogParams[2].y * r1.x;
    r0.w = rsqrt(r0.w);
    r2.xyz = r6.xyz * r0.www;
    r0.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
    r0.w = log2(r0.w);
    r0.w = globalFogParams[4].w * r0.w;
    r0.w = exp2(r0.w);
    r1.w = saturate(dot(r2.xyz, globalFogParams[3].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[3].w * r1.w;
    r1.w = exp2(r1.w);
    r1.x = -r1.x * globalFogParams[2].y + 1;
    r1.x = globalFogParams[1].y * r1.x;
    r2.x = -globalFogParams[2].x + r1.y;
    r2.x = max(0, r2.x);
    r2.x = globalFogParams[1].x * r2.x;
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r1.z = saturate(r1.x * r2.x + r1.z);
    r1.y = -globalFogParams[1].z * r1.y;
    r1.y = 1.44269502 * r1.y;
    r1.y = exp2(r1.y);
    r1.y = 1 + -r1.y;
    r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r2.xyz = r0.www * r2.xyz + globalFogColorE.xyz;
    r3.xyz = globalFogColor.xyz + -r2.xyz;
    r2.xyz = r1.www * r3.xyz + r2.xyz;
    r2.xyz = -globalFogColorN.xyz + r2.xyz;
    r2.xyz = r1.yyy * r2.xyz + globalFogColorN.xyz;
    r3.x = globalFogColor.w;
    r3.y = globalFogColorE.w;
    r3.z = globalFogColorN.w;
    r3.xyz = r3.xyz + -r2.xyz;
    r1.xyw = r1.xxx * r3.xyz + r2.xyz;
    r0.w = cmp(0 < gGlobalFogIntensity);
    if (r0.w != 0) {
      r2.xy = globalScreenSize.zw * v7.xy;
      r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
      r0.w = -1 + r2.x;
      r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
    } else {
      r0.w = 1;
    }
    r1.xyw = r1.xyw * r0.www + -r0.xyz;
    r1.xyz = r1.zzz * r1.xyw + r0.xyz;
  } else {
    r0.w = dot(r6.xyz, r6.xyz);
    r1.w = sqrt(r0.w);
    r2.x = -globalFogParams[0].x + r1.w;
    r2.x = max(0, r2.x);
    r1.w = r2.x / r1.w;
    r1.w = r6.z * r1.w;
    r2.y = globalFogParams[2].z * r1.w;
    r1.w = cmp(0.00999999978 < abs(r1.w));
    r2.z = -1.44269502 * r2.y;
    r2.z = exp2(r2.z);
    r2.z = 1 + -r2.z;
    r2.y = r2.z / r2.y;
    r1.w = r1.w ? r2.y : 1;
    r2.y = globalFogParams[1].w * r2.x;
    r1.w = r2.y * r1.w;
    r1.w = min(1, r1.w);
    r1.w = 1.44269502 * r1.w;
    r1.w = exp2(r1.w);
    r1.w = min(1, r1.w);
    r1.w = 1 + -r1.w;
    r2.y = globalFogParams[2].y * r1.w;
    r0.w = rsqrt(r0.w);
    r3.xyz = r6.xyz * r0.www;
    r0.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
    r0.w = log2(r0.w);
    r0.w = globalFogParams[4].w * r0.w;
    r0.w = exp2(r0.w);
    r2.z = saturate(dot(r3.xyz, globalFogParams[3].xyz));
    r2.z = log2(r2.z);
    r2.z = globalFogParams[3].w * r2.z;
    r2.z = exp2(r2.z);
    r1.w = -r1.w * globalFogParams[2].y + 1;
    r1.w = globalFogParams[1].y * r1.w;
    r2.w = -globalFogParams[2].x + r2.x;
    r2.w = max(0, r2.w);
    r2.w = globalFogParams[1].x * r2.w;
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r2.y = saturate(r1.w * r2.w + r2.y);
    r2.x = -globalFogParams[1].z * r2.x;
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r0.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.zzz * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r2.xzw = r2.xxx * r3.xyz + globalFogColorN.xyz;
    r3.x = globalFogColor.w;
    r3.y = globalFogColorE.w;
    r3.z = globalFogColorN.w;
    r3.xyz = r3.xyz + -r2.xzw;
    r2.xzw = r1.www * r3.xyz + r2.xzw;
    r2.xzw = r2.xzw + -r0.xyz;
    r1.xyz = r2.yyy * r2.xzw + r0.xyz;
  }
  o0.xyz = globalScalars3.zzz * r1.xyz;
  return;
}
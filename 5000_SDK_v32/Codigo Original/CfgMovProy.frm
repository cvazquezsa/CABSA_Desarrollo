[Forma]
Clave=CfgMovProy
Nombre=Configurar Movimientos Proyectos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=393
PosicionInicialArriba=237
PosicionInicialAlturaCliente=215
PosicionInicialAncho=580
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgMovProy
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.CfgMovProy.Modulo]
Carpeta=Lista
Clave=CfgMovProy.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CfgMovProy.Mov]
Carpeta=Lista
Clave=CfgMovProy.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CfgMovProy.Tipo]
Carpeta=Lista
Clave=CfgMovProy.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Columnas]
Modulo=49
Mov=166
Tipo=87
Factor=42
Resultado=95

SubTipo=103
Proveedor=81
0=116
1=266
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.CfgMovProy.Factor]
Carpeta=Lista
Clave=CfgMovProy.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.CfgMovProy.SubTipo]
Carpeta=Lista
Clave=CfgMovProy.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=CfgMovProy.Modulo
CfgMovProy.Modulo=CfgMovProy.Mov
CfgMovProy.Mov=CfgMovProy.Tipo
CfgMovProy.Tipo=CfgMovProy.Factor
CfgMovProy.Factor=CfgMovProy.SubTipo
CfgMovProy.SubTipo=CfgMovProy.Proveedor
CfgMovProy.Proveedor=(Fin)

[Lista.CfgMovProy.Proveedor]
Carpeta=Lista
Clave=CfgMovProy.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[FormaExtraValor.Columnas]
VerCampo=278
VerValor=303

[SituacionCta.Columnas]
0=188
1=148
2=-2
3=-2
4=-2

[(Carpeta Abrir).Columnas]
0=114
1=362

[Acciones.ConceptosRH]
Nombre=ConceptosRH
Boton=11
NombreEnBoton=S
NombreDesplegar=&Conceptos RH
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ConceptosRH
Activo=S



















VisibleCondicion=Si (CfgMovProy:CfgMovProy.Mov = <T>Presupuesto RH<T>) y (CfgMovProy:CfgMovProy.SubTipo = <T>Recurso Humano<T>)<BR>Entonces Verdadero<BR>Sino Falso<BR>Fin


























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ConceptosRH
ConceptosRH=(Fin)

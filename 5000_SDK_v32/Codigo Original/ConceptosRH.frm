
[Forma]
Clave=ConceptosRH
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Conceptos Presupuestos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=ListaConceptosRH
CarpetaPrincipal=ListaConceptosRH
PosicionInicialIzquierda=263
PosicionInicialArriba=179
PosicionInicialAlturaCliente=109
PosicionInicialAncho=309
PosicionCol1=162
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Aceptar

[ListaConceptosRH]
Estilo=Ficha
Clave=ListaConceptosRH
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConceptosRH
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

ListaEnCaptura=(Lista)
[ListaConceptosRH.Columnas]
ConceptoCosto=604

[Lista.Columnas]
0=252




[ListaConceptosRH.ConceptosRH.ConceptoRH]
Carpeta=ListaConceptosRH
Clave=ConceptosRH.ConceptoRH
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[ListaConceptosRH.ConceptosRH.ConceptoStaff]
Carpeta=ListaConceptosRH
Clave=ConceptosRH.ConceptoStaff
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco











[ListaConceptosRH.ListaEnCaptura]
(Inicio)=ConceptosRH.ConceptoRH
ConceptosRH.ConceptoRH=ConceptosRH.ConceptoStaff
ConceptosRH.ConceptoStaff=(Fin)

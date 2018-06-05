
[Forma]
Clave=eDocCopiar
Icono=0
Modulos=(Todos)
Nombre=Copiar Documento Electrónico

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraAcciones=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=170
PosicionInicialAncho=260
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=510
PosicionInicialArriba=260
BarraHerramientas=S
Comentarios=Lista(Info.Modulo,Info.Descripcion)
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaBloquearAjuste=S
[(Variables)]
Estilo=Ficha
Clave=(Variables)
InicializarVariables=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S



[(Variables).Temp.Modulo]
Carpeta=(Variables)
Clave=Temp.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[(Variables).Info.eDoc]
Carpeta=(Variables)
Clave=Info.eDoc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=&Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S










[(Variables).ListaEnCaptura]
(Inicio)=Temp.Modulo
Temp.Modulo=Info.eDoc
Info.eDoc=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

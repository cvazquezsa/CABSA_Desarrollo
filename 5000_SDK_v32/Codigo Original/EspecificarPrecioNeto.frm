[Forma]
Clave=EspecificarPrecioNeto
Nombre=<T>Precio Neto<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=401
PosicionInicialArriba=329
PosicionInicialAlturaCliente=76
PosicionInicialAncho=221
BarraAcciones=S
AccionesTamanoBoton=15x5
AccionesDivision=S
ListaAcciones=(Lista)
AccionesCentro=S
VentanaEscCerrar=S
VentanaExclusiva=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
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
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Precio
CarpetaVisible=S

[(Variables).Info.Precio]
Carpeta=(Variables)
Clave=Info.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Variables Asignar / Ventana Aceptar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

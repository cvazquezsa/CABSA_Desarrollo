
[Forma]
Clave=ClasificacionConcFEFondos
Icono=0
Modulos=(Todos)
Nombre=Clasificación Flujo de Efectivo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=273
PosicionInicialAncho=433
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaColor=Plata
PosicionInicialIzquierda=465
PosicionInicialArriba=211
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ClasificacionConcFEFondos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.ClasificacionConcFEFondos.Clasificacion]
Carpeta=Lista
Clave=ClasificacionConcFEFondos.Clasificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Clasificacion=304

Cuenta=124
EsConcentradora=90
[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S
















[Lista.ClasificacionConcFEFondos.EsConcentradora]
Carpeta=Lista
Clave=ClasificacionConcFEFondos.EsConcentradora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=ClasificacionConcFEFondos.Clasificacion
ClasificacionConcFEFondos.Clasificacion=ClasificacionConcFEFondos.EsConcentradora
ClasificacionConcFEFondos.EsConcentradora=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=(Fin)

[Forma]
Clave=mcCargaMayor
Nombre=Carga en Lote
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=470
PosicionInicialArriba=376
PosicionInicialAlturaCliente=411
PosicionInicialAncho=980
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcCargaMayor
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cuenta Mayor<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Cuentas Mayor
IconosNombre=mcCargaMayor:mcMayor.Mayor

[Lista.mcMayor.Nombre]
Carpeta=Lista
Clave=mcMayor.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaMayor.Debe]
Carpeta=Lista
Clave=mcCargaMayor.Debe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaMayor.Haber]
Carpeta=Lista
Clave=mcCargaMayor.Haber
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaMayor.Presupuesto]
Carpeta=Lista
Clave=mcCargaMayor.Presupuesto
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaMayor.Existencia]
Carpeta=Lista
Clave=mcCargaMayor.Existencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCargaMayor.porSurtir]
Carpeta=Lista
Clave=mcCargaMayor.porSurtir
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=93
1=256

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Refrescar]
Nombre=Refrescar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Carga]
Nombre=Carga
Boton=47
NombreEnBoton=S
NombreDesplegar=&Carga
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=mcCargaReg
Activo=S
ConCondicion=S
EjecucionCondicion=no mcCargaMayor:mcMayor.EsAcumulativa
Antes=S
AntesExpresiones=Asigna(Info.Mayor, mcCargaMayor:mcMayor.Mayor)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Carga
Carga=Refrescar
Refrescar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcMayor.Nombre
mcMayor.Nombre=mcCargaMayor.Debe
mcCargaMayor.Debe=mcCargaMayor.Haber
mcCargaMayor.Haber=mcCargaMayor.Presupuesto
mcCargaMayor.Presupuesto=mcCargaMayor.Existencia
mcCargaMayor.Existencia=mcCargaMayor.porSurtir
mcCargaMayor.porSurtir=(Fin)

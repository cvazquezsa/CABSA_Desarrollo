[Forma]
Clave=EspecificarSugerirWMS
Nombre=<T>Especificar Agente/Zona<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
PosicionInicialIzquierda=802
PosicionInicialArriba=430
PosicionInicialAltura=108
PosicionInicialAncho=315
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=140
VentanaSiempreAlFrente=S
VentanaEstadoInicial=Normal

BarraHerramientas=S
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=62
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S


[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreDesplegar=&Afectar
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
NombreEnBoton=S
EnBarraHerramientas=S

[(Variables).Info.WMSSugerirPor]
Carpeta=(Variables)
Clave=Info.WMSSugerirPor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






































[Acciones.Aceptar.VariablesAsignar]
Nombre=VariablesAsignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=EjecutarSQL(<T>EXEC spWMSSugerirMontacargaTarea :nEstacionTrabajo, :tEmpresa, :nPorZona, :tPrioridad<T>, EstacionTrabajo, Empresa, Si(Info.WMSSugerirPor=<T>Zona<T>,0,1), Info.WMSPrioridad)     <BR>ActualizarForma
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[(Variables).Info.WMSPrioridad]
Carpeta=(Variables)
Clave=Info.WMSPrioridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=10
ColorFondo=Blanco
















[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


















[(Variables).ListaEnCaptura]
(Inicio)=Info.WMSSugerirPor
Info.WMSSugerirPor=Info.WMSPrioridad
Info.WMSPrioridad=(Fin)




































[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=VariablesAsignar
VariablesAsignar=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)


[Forma]
Clave=NOINominaEspecial
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=Nomina Especial
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=NOINominaEspecial
BarraHerramientas=S

ListaCarpetas=NOINominaEspecial
PosicionInicialIzquierda=658
PosicionInicialArriba=362
PosicionInicialAlturaCliente=81
PosicionInicialAncho=284
ListaAcciones=(Lista)
ExpresionesAlMostrar=EjecutarSQL(<T>spNOINominaEspecial :nEstacion<T>,EstacionTrabajo)
[NOINominaEspecial]
Estilo=Ficha
Clave=NOINominaEspecial
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOINominaEspecial
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
ListaEnCaptura=NOINominaEspecial.Mov
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=NOINominaEspecial.Estacion = {EstacionTrabajo}
[NOINominaEspecial.NOINominaEspecial.Mov]
Carpeta=NOINominaEspecial
Clave=NOINominaEspecial.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Mov,SQL(<T>SELECT Mov FROM NOINominaEspecial WHERE Estacion = :nEstacion<T>,EstacionTrabajo))<BR>EjecutarSQL(<T>spNOIGenerarPersonal :tEmpresa,:tNomina,:tUsuario,:nEstacion<T>,Empresa,Info.Aplica,Usuario,EstacionTrabajo)<BR>ProcesarSQL(<T>spNOIGenerarNomina :tEmpresa,:tNomina,:tUsuario,:nEstacion,:tMov<T>,Empresa,Info.Aplica,Usuario,EstacionTrabajo,Info.Mov)
Activo=S
Visible=S

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
